pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        node {
          label 'dind'
        }

      }
      steps {
        sh 'docker build -t chronicc/jenkins-agend-dind:latest-dev .'
        sh 'docker push chronicc/jenkins-agend-dind:latest-dev'
      }
    }

  }
}