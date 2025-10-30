pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-app"
        CONTAINER_NAME = "flask"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "📦 Cloning Flask app from GitHub..."
                git branch: 'main', url: 'https://github.com/gopinath954/flask-examples.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                dir('template') { // move into folder with Dockerfile and app.py
                    sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Stop Previous Container') {
            steps {
                echo "🛑 Stopping any previous container..."
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "🚀 Running Flask Docker container..."
                sh """
                    docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${BUILD_NUMBER}
                """
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "🔍 Checking container status..."
                sh "docker ps | grep ${CONTAINER_NAME}"
            }
        }
    }

    post {
        always {
            echo "🏁 Pipeline finished."
        }
        success {
            echo "✅ Flask app deployed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check the logs."
        }
    }
}
