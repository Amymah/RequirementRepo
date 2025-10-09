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
                bat 'robot nestedframe.robot'
                bat 'robot nestedframe2.robot'
            }
        }
    }

    post {
        always {
            // Archive reports
            archiveArtifacts artifacts: '**/log.html, **/report.html, **/output.xml', allowEmptyArchive: true

            // Send email notification
            emailext(
                subject: "Robot Test Results: ${env.JOB_NAME} #${env.BUILD_NUMBER} - ${currentBuild.currentResult}",
                body: """
                    <h3>Jenkins Build Notification</h3>
                    <p>Job: <b>${env.JOB_NAME}</b></p>
                    <p>Build Number: <b>${env.BUILD_NUMBER}</b></p>
                    <p>Status: <b style='color:${currentBuild.currentResult == "SUCCESS" ? "green" : "red"}'>
                        ${currentBuild.currentResult}
                    </b></p>
                    <p>You can view the build details and reports here:</p>
                    <a href="${env.BUILD_URL}">${env.BUILD_URL}</a>
                """,
                to: 'amymahu1@outlook.com, amyma.usman@bssuniversal.com',
                mimeType: 'text/html',
                attachmentsPattern: '**/report.html, **/log.html'
            )
        }
    }
}
