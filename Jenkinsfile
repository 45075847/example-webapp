def productionImage
def ACCOUNT_REGISTRY_PREFIX
def GIT_COMMIT_HASH 

pipeline {
    agent any

    environment {
        ACCOUNT_REGISTRY_PREFIX = "crpi-rxm100aep1nibg3h.cn-hangzhou.personal.cr.aliyuncs.com/a1025z"
    }
    
    stages {
        stage('Checkout Source Code and Logging Into Registry') {
            steps {
                echo 'Logging Into the Private ECR Registry'
                script {
                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true).trim()
                    echo "Git Commit Hash: ${GIT_COMMIT_HASH}"
                    env.GIT_COMMIT_HASH = GIT_COMMIT_HASH
                    echo 'Logging into the Private Registry'
                    sh 'docker login --username=a1025z --password=Wldofdm999$ ${ACCOUNT_REGISTRY_PREFIX}'
                }
            }
        }

        stage('Make A Builder Image') {
            steps {
                echo 'Starting to build the project builder docker image'
                script {
                    echo "ACCOUNT_REGISTRY_PREFIX: ${env.ACCOUNT_REGISTRY_PREFIX}"
                    def builderImage = docker.build("${env.ACCOUNT_REGISTRY_PREFIX}/example-webapp-builder:${env.GIT_COMMIT_HASH}", "-f Dockerfile.builder .")
                    builderImage.push()
                    builderImage.push("${env.BRANCH_NAME}")
                    builderImage.inside('-v $WORKSPACE:/output -u root') {
                    //Download is too slow. Ignore below commands since jar is already generated.
                    /*sh """
                        cd /output
                        lein uberjar
                    """*/
                    }
                }
            }
        }

        stage('Unit Tests') {
            steps {    
                echo 'running unit tests in the builder image.'
                script {
                    echo "WORKSPACE: $WORKSPACE"
                    /* builderImage.inside('-v $WORKSPACE:/output -u root') {
                    Ignore below scripts - same reason as above step
                    sh """
                        cd /output
                        lein test
                    """
                    }*/
                }
            }
        }

    }
}
