pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        S3_BUCKET = 'barista-cafe-website-demo'
        CF_DISTRIBUTION = 'E12ABC34XYZ'   // your real ID here
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/username/static-website.git'
            }
        }

        stage('Upload to S3') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-cred'
                ]]) {
                    sh '''
                        aws s3 sync . s3://$S3_BUCKET --delete
                    '''
                }
            }
        }

        stage('Invalidate CloudFront Cache') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-cred'
                ]]) {
                    sh '''
                        aws cloudfront create-invalidation \
                          --distribution-id $CF_DISTRIBUTION \
                          --paths "/*"
                    '''
                }
            }
        }
    }
}
