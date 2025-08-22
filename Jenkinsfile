pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile in workspace root
                    def customImage = docker.build("my-python-app:${env.BUILD_ID}")
                    // Save the image for later stages
                    env.IMAGE_NAME = customImage.id
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests inside the built Docker container
                    docker.image(env.IMAGE_NAME).inside {
                        sh 'pytest --junit-xml test-reports/results.xml sources/test_calc.py'
                    }
                }
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }

        stage('Deliver') {
            steps {
                script {
                    // Build executable with pyinstaller inside the container
                    docker.image(env.IMAGE_NAME).inside {
                        sh 'pyinstaller --onefile sources/add2vals.py'
                    }
                }
                // Archive the generated binary
                archiveArtifacts 'dist/add2vals'
            }
        }
    }
}
