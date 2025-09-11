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
                // Install everything from requirements.txt
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat 'robot nestedframe.robot'
                bat 'robot nestedframe2.robot'
                bat 'robot OrangeHRM.robot'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/log.html, **/report.html, **/output.xml', allowEmptyArchive: true
        }
    }
}
