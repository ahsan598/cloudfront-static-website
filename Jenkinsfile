pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        S3_BUCKET = 'YOUR_BUCKET_NAME'
        CF_DISTRIBUTION = 'YOUR_DISTRIBUTION_ID'
    }

    stages {

        stage('Checkout') {
            steps {
                git checkout scm
            }
        }

        stage('Upload to S3') {
            steps {
                sh '''
                    aws s3 sync . s3://$S3_BUCKET --delete
                '''
            }
        }

        stage('Invalidate CloudFront Cache') {
            steps {
                sh '''
                    aws cloudfront create-invalidation \
                      --distribution-id $CF_DISTRIBUTION \
                      --paths "/*"
                '''
            }
        }
    }
}
