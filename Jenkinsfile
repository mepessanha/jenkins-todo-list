pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        sh 'echo "Executando build..."'
      }
    }
  }

  post {
    always {
      sh 'ci/slack_notify.sh "${JOB_NAME} #${BUILD_NUMBER}: build finalizado (status: ${currentBuild.currentResult})"'
    }
    success {
      sh 'ci/slack_notify.sh "${JOB_NAME} #${BUILD_NUMBER}: SUCESSO"' 
    }
    failure {
      sh 'ci/slack_notify.sh "${JOB_NAME} #${BUILD_NUMBER}: FALHOU — veja ${BUILD_URL}"'
    }
    unstable {
      sh 'ci/slack_notify.sh "${JOB_NAME} #${BUILD_NUMBER}: UNSTABLE — veja ${BUILD_URL}"'
    }
    aborted {
      sh 'ci/slack_notify.sh "${JOB_NAME} #${BUILD_NUMBER}: ABORTADO"'
    }
  }
}