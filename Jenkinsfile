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
        sh 'make step.pull'
        sh 'make step.build'
        sh 'make step.tag'
        script {
          withCredentials([
            usernamePassword(credentialsId: 'dockerhub_credentials',
            usernameVariable: 'USERNAME',
            passwordVariable: 'PASSWORD')
          ]) {
            sh 'make step.login REGISTRY_USERNAME=USERNAME REGISTRY_PASSWORD=PASSWORD'
          }
        }
        sh 'make step.push'
      }
    }

  }
}

