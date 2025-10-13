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

        stage('Run Robot Tests (Local)') {
            steps {
                echo "Running Robot Tests on Local Jenkins machine..."
                // Ensure Testcase folder exists
                bat 'if not exist Testcase mkdir Testcase'

                // Run Robot tests
                bat 'robot --output Testcase\\output.xml --log Testcase\\log.html --report Testcase\\report.html Testcase\\*.robot'
            }
        }
    }

    post {
        success {
            script {
                echo "Local job succeeded. Sending success email..."

                try {
                    // Send success email
                    emailext(
                        subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                        body: """
                            <h3>Jenkins Build Success Notification</h3>
                            <p><b>Job:</b> ${env.JOB_NAME}</p>
                            <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                            <p>Status: <b style='color:green;'>SUCCESS</b></p>
                            <p>Robot test reports generated successfully.</p>
                        """,
                        to: 'amymahu1@outlook.com, amyma.usman@bssuniversal.com',
                        mimeType: 'text/html',
                        attachmentsPattern: 'Testcase/report*.html, Testcase/log*.html'
                    )

                    echo "Email sent successfully. Now triggering remote job..."

                    // Trigger the remote job only after successful email
                    build job: 'Remote_Test_Job', wait: false

                } catch (Exception e) {
                    echo "Email sending failed, remote job will not be triggered."
                }
            }
        }

        failure {
            echo "Local job failed. No email or remote trigger will occur."
        }

        always {
            echo "Build completed."
            archiveArtifacts artifacts: 'Testcase/report*.html, Testcase/log*.html', allowEmptyArchive: true
        }
    }
}
