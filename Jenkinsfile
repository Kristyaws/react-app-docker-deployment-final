pipeline {
    agent any

    environment {
        DOCKER_PROD_REPO = 'kristyaws/prod'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        GIT_CREDENTIALS_ID = 'git-credentials'
        GIT_REPO_URL = 'https://github.com/Kristyaws/react-app-docker-deployment-final.git'
        BRANCH_NAME = 'master'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([ 
                        $class: 'GitSCM',
<<<<<<< HEAD
                        branches: [[name: "*/${BRANCH_NAME}"]],
=======
                        branches: [[name: "*/${env.GIT_BRANCH}"]],
>>>>>>> 4a55d94 (Update Jenkinsfile)
                        userRemoteConfigs: [[
                            url: "${GIT_REPO_URL}",
                            credentialsId: "${GIT_CREDENTIALS_ID}"
                        ]]]
                    )
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh './build.sh'
                }
            }
        }

        stage('Push Docker Image') {
            when {
<<<<<<< HEAD
                branch 'master'
            }
            steps {
                script {
                    def dockerRepo = DOCKER_PROD_REPO
                    def buildTag = "${dockerRepo}:${env.BUILD_NUMBER}"
                    sh "docker build -t ${buildTag} ."
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                    }
                    sh "docker push ${buildTag}"
=======
                anyOf {
                    branch 'dev'
                    branch 'master'
                }
            }
            steps {
                script {
                    def dockerRepo = env.GIT_BRANCH == 'master' ? DOCKER_PROD_REPO : DOCKER_DEV_REPO

                    // Build the Docker image
                    sh "docker build -t ${dockerRepo}:${env.BUILD_NUMBER} ."

                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                    }

                    // Push the Docker image
                    sh "docker push ${dockerRepo}:${env.BUILD_NUMBER}"
>>>>>>> 4a55d94 (Update Jenkinsfile)
                }
            }
        }

        stage('Deploy Docker Containers') {
            steps {
                script {
                    def buildTag = "${DOCKER_PROD_REPO}:${env.BUILD_NUMBER}"
                    sh "docker pull ${buildTag}"
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
