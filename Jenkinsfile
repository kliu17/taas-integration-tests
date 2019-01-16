def loop_of_sh(list) {
    for (int i = 0; i < list.size(); i++) {
        sh "inspec exec /tmp/taas-integration-tests/profile/controls/ -t ssh://ec2-user@${list[i]} --reporter cli json:$BUILD_NUMBER/json/${list[i]}.output.json junit:$BUILD_NUMBER/junitreport/${list[i]}.junit.xml html:$BUILD_NUMBER/www/${list[i]}.index.html || true"
    }
}

hosts = ['10.2.6.149']

pipeline {
  agent {
    kubernetes {
      label 'taaspod'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: taas-jenkins-slave
  annotations:
    iam.amazonaws.com/role: arn:aws:iam::884956725745:role/taas-NodeInstanceRole-1P30OR4Q5QLT3
spec:
  containers:
  - name: taas
    image: kliu17/taas:taas_docker_image_2019_1_15_3
    command:
    - cat
    tty: true
"""
    }
  }

  environment {
        AWS_REGION = 'us-east-1'
        AWS_PROFILE = 'kenzan-scratch-platformtaas'
  }

  stages {
    stage('build') {
      steps {
        container('taas') {
          sshagent (credentials: ['taas-ssh']) {
            sh 'inspec version'
            sh 'bundle exec kitchen'
            sh 'echo "[profile kenzan-scratch-platformtaas]" >> ~/.aws/config'
            sh 'echo "region = us-east-1" >> ~/.aws/config'
            sh 'aws --version'
            sh 'aws eks update-kubeconfig --name taas'
            sh 'kubectl version'
            sh 'helm init'
	    sh 'git clone https://github.com/kliu17/taas-integration-tests /tmp/taas-integration-tests'
	    loop_of_sh(hosts)
         }
        }
      }
   post {
  always {
	archiveArtifacts artifacts: '$BUILD_NUMBER/*/*', fingerprint: true
        // publish html
        publishHTML target: [
            allowMissing: false,
            alwaysLinkToLastBuild: false,
            keepAll: true,
            reportDir: '$BUILD_NUMBER/www',
            reportFiles: '*.index.html',
            reportName: 'TaaS HTML Report'
          ]
        junit "$BUILD_NUMBER/junitreport/*.xml"
  }

    }

}
  }

}
