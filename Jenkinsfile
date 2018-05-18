node {
  try {
    stage('Checkout') {
      checkout scm
    }
    stage('Environment') {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'docker -v'
      sh 'printenv'
    }
    stage('Build Docker test'){
     sh 'docker build -t django_pruebas-test -f Dockerfile.test --no-cache .'
    }
    stage('Docker test'){
      sh "docker run --name django_pruebas_${env.BUILD_ID} django_pruebas-test;docker cp django_pruebas_${env.BUILD_ID}:/results .;docker rm django_pruebas_${env.BUILD_ID}"
	  step([$class: 'CoberturaPublisher', autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'results/coverage.xml', failUnhealthy: false, failUnstable: false, maxNumberOfBuilds: 0, onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false])
      junit 'results/xmlrunner/**/*.xml'
    }
    stage('Clean Docker test'){
      sh 'docker rmi django_pruebas-test'
    }
    stage('Deploy'){
      if(env.BRANCH_NAME == 'master'){
        sh 'docker build -t django_pruebas-app --no-cache .'
//        sh 'docker tag react-app localhost:5000/react-app'
//        sh 'docker push localhost:5000/react-app'
//        sh 'docker rmi -f react-app localhost:5000/react-app'
      }
    }
  }
  catch (err) {
    throw err
  }
}
