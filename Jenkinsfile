pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = 'kristyaws/dev'
        DOCKER_PROD_REPO = 'kristyaws/prod'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        GIT_CREDENTIALS_ID = 'git-credentials'
        GIT_REPO_URL = 'https://github.com/Kristyaws/react-app-docker-deployment-final.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/${env.BRANCH_NAME}']],
                        userRemoteConfigs: [[
                            url: "${GIT_REPO_URL}",
                            credentialsId: "${GIT_CREDENTIALS_ID}"
                        ]]
                    ])
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    // Execute build.sh script
                    sh './build.sh'
                }
            }
        }

        stage('Deploy Docker Containers') {
            steps {
                script {
                    // Execute deploy.sh script
                    sh './deploy.sh'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed.'
        }
    }
}
