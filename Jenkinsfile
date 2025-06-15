def builderImage
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
                    builderImage = docker.build("${env.ACCOUNT_REGISTRY_PREFIX}/example-webapp-builder:${env.GIT_COMMIT_HASH}", "-f Dockerfile.builder .")
                    builderImage.push()
                    builderImage.push("${env.BRANCH_NAME}")
                    builderImage.inside('-v $WORKSPACE:/output -u root') {
                    //Download is too slow. Ignore below commands since jar is already generated.
                    /*sh """
                        cd /output
                        lein uberjar
                    """
                    */
                    }
                }
            }
        }

        stage('Unit Tests') {
            steps {    
                echo 'running unit tests in the builder image.'
                script {
                    echo "WORKSPACE: $WORKSPACE"
                    builderImage.inside('-v $WORKSPACE:/output -u root') {
                    //Ignore below scripts - same reason as above step
                    /*sh """
                        cd /output
                        lein test
                    """
                    */
                    }
                }
            }
        }

        stage('Build Production Image') {
            steps {
                echo 'Starting to build docker image'
                script {
                    productionImage = docker.build("${env.ACCOUNT_REGISTRY_PREFIX}/example-webapp:${env.GIT_COMMIT_HASH}")
                    productionImage.push()
                    productionImage.push("${env.GIT_BRANCH}") 
                }
            }
        }

        stage('Deploy to Production - Fixed S+erver') {  
            when {
                branch 'release'
            }
            steps {
                echo 'Deploying release to production'
                script {
                    productionImage.push("deploy")
                    //Put you start scripts here to start production docker image on production server
                    /*sh """
                      aws ec2 reboot-instances --region us-east-1 --instance-ids i-0e438e2bf64427c9d
                    """
                    */
                }
            }
        }

        stage('Deploy to Production - AWS CloudFormation') {
            when {
                branch 'master'
            }
            steps {
                script {
                    PRODUCTION_ALB_LISTENER_ARN="arn:aws:elasticloadbalancing:us-east-1:089778365617:listener/"
                    /*sh '''
                        ./run-stack.sh example-webapp-production ${PRODUCTION_ALB_LISTENER_ARN}
                    '''
                    */
                }
            }
        }

    }
}
