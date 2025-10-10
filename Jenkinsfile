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
                // Ensure the Testcase folder exists
                bat 'if not exist Testcase mkdir Testcase'

                // Run all test cases in Testcase folder and generate a single combined HTML report
                bat '''
                    robot --output Testcase\\output.xml ^
                          --log Testcase\\log.html ^
                          --report Testcase\\report.html ^
                          Testcase
                '''
            }
        }
    }

    post {
        always {
            // Archive the generated report and log
            archiveArtifacts artifacts: 'Testcase/report.html, Testcase/log.html', allowEmptyArchive: true

            // Send email with the HTML report attached
            emailext(
                subject: "Robot Test Results: ${env.JOB_NAME} #${env.BUILD_NUMBER} - ${currentBuild.currentResult}",
                body: """
                    <h3>Jenkins Build Notification</h3>
                    <p>Job: <b>${env.JOB_NAME}</b></p>
                    <p>Build Number: <b>${env.BUILD_NUMBER}</b></p>
                    <p>Status: <b style='color:${currentBuild.currentResult == "SUCCESS" ? "green" : "red"}'>
                        ${currentBuild.currentResult}
                    </b></p>
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
