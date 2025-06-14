def builderImage
def productionImage
def ACCOUNT_REGISTRY_PREFIX
def GIT_COMMIT_HASH

pipeline {
    agent any
    stages {
        stage('Checkout Source Code and Logging Into Registry') {
            steps {
                echo 'Logging Into the Private ECR Registry'
                script {
                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true).trim()
                    echo 'Git Commit Hash:'
                    echo GIT_COMMIT_HASH
                    ACCOUNT_REGISTRY_PREFIX = "crpi-rxm100aep1nibg3h.cn-hangzhou.personal.cr.aliyuncs.com/a1025z"
                    //sh """
                    //    \$(aws ecr get-login --no-include-email --region us-east-1)
                    //"""
                }
            }
        }

        stage('Make A Builder Image') {
            steps {
                echo 'Starting to build the project builder docker image'
                script {
                    //builderImage = docker.build("${ACCOUNT_REGISTRY_PREFIX}/example-webapp-builder:${GIT_COMMIT_HASH}")
                    //builderImage.push()
                    //builderImage.push("${env.GIT_BRANCH}")
                    //builderImage.inside('-v $WORKSPACE:/output -u root') {
                    //sh """
                    //    cd /output
                    //    lein uberjar
                    //"""
                }
            }
        }

    }
}
