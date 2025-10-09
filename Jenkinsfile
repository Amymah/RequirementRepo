pipeline {
    agent any

    stages {
        stage('Check Python') {
            steps {
                bat 'python --version'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            steps {
                // Run both test files and store outputs separately
                bat 'robot --output output1.xml Testcase\\nestedframe.robot'
                bat 'robot --output output2.xml Testcase\\nestedframe2.robot'

                // Combine the two result files into a single report in testcase folder
                bat 'rebot --merge --output Testcase\\output.xml Testcase\\output1.xml Testcase\\output2.xml'

                // Generate a single final report in testcase folder
                bat 'rebot --name "Combined Test Report" --output Testcase\\output.xml --log Testcase\\log.html --report Testcase\\report.html Testcase\\output.xml'
            }
        }
    }

    post {
        always {
            // Archive the combined reports from the testcase folder
            archiveArtifacts artifacts: 'Testcase/log.html, Testcase/report.html, Testcase/output.xml', allowEmptyArchive: true

            // Send email notification with combined report
            emailext(
                subject: "Robot Test Results: ${env.JOB_NAME} #${env.BUILD_NUMBER} - ${currentBuild.currentResult}",
                body: """
                    <h3>Jenkins Build Notification</h3>
                    <p>Job: <b>${env.JOB_NAME}</b></p>
                    <p>Build Number: <b>${env.BUILD_NUMBER}</b></p>
                    <p>Status: <b style='color:${currentBuild.currentResult == "SUCCESS" ? "green" : "red"}'>
                        ${currentBuild.currentResult}
                    </b></p>
                    <p>Combined test report has been generated for all Robot test cases.</p>
                    <p>View full report here:</p>
                    <a href="${env.BUILD_URL}">${env.BUILD_URL}</a>
                """,
                to: 'amymahu1@outlook.com, amyma.usman@bssuniversal.com',
                mimeType: 'text/html',
                attachmentsPattern: 'Testcase/report.html, Testcase/log.html'
            )
        }
    }
}
