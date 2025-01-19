pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = 'kristyaws/dev'
        DOCKER_PROD_REPO = 'kristyaws/prod'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        GIT_CREDENTIALS_ID = 'git-credentials'
        GIT_REPO_URL = 'https://github.com/Kristyaws/react-app-docker-deployment-final.git'
        DEV_BRANCH = 'dev'
        MASTER_BRANCH = 'master'
        BRANCH_NAME = "${env.BRANCH_NAME ?: env.GIT_BRANCH}" // Use GIT_BRANCH if BRANCH_NAME is not set
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: "*/${BRANCH_NAME}"]],
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

        stage('Push Docker Image') {
            when {
                anyOf {
                    branch "${env.DEV_BRANCH}"
                    branch "${env.MASTER_BRANCH}"
                }
            }
            steps {
                script {
                    def dockerRepo = BRANCH_NAME == env.MASTER_BRANCH ? DOCKER_PROD_REPO : DOCKER_DEV_REPO

                    // Build the Docker image
                    sh "docker build -t ${dockerRepo}:${env.BUILD_NUMBER} ."

                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                    }

                    // Push the Docker image
                    sh "docker push ${dockerRepo}:${env.BUILD_NUMBER}"
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
