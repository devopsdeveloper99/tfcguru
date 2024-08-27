pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = ''
        AWS_SECRET_ACCESS_KEY = ''
        AWS_SESSION_TOKEN = ''
    }

    stages {
        stage('SAML Authentication') {
            steps {
                script {
                    // Run the provided script to authenticate and retrieve AWS credentials
                    sh '''
                    #!/bin/bash
                    # Authenticate with saml2aws
                    saml2aws login --profile <profile-name> --skip-prompt

                    # Export credentials as environment variables
                    export AWS_ACCESS_KEY_ID=$(aws configure get <profile-name>.aws_access_key_id)
                    export AWS_SECRET_ACCESS_KEY=$(aws configure get <profile-name>.aws_secret_access_key)
                    export AWS_SESSION_TOKEN=$(aws configure get <profile-name>.aws_session_token)

                    # Set the environment variables in Jenkins pipeline
                    echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env
                    echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env
                    echo "AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" >> .env
                    '''
                }
            }
        }

        stage('Set Environment Variables') {
            steps {
                script {
                    def props = readProperties(file: '.env')
                    env.AWS_ACCESS_KEY_ID = props['AWS_ACCESS_KEY_ID']
                    env.AWS_SECRET_ACCESS_KEY = props['AWS_SECRET_ACCESS_KEY']
                    env.AWS_SESSION_TOKEN = props['AWS_SESSION_TOKEN']
                }
            }
        }
        
        stage('Run AWS CLI Command') {
            steps {
                script {
                    // Run AWS CLI command using the authenticated credentials
                    sh 'aws s3 ls --profile <profile-name>'
                }
            }
        }
    }

    post {
        always {
            // Clean up the .env file
            sh 'rm -f .env'
        }
    }
}




pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_SESSION_TOKEN = credentials('aws-session-token')
    }
    stages {
        stage('AWS Command') {
            steps {
                script {
                    sh '''
                    aws s3 ls
                    '''
                }
            }
        }
    }
}



................
