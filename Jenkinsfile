pipeline {
  agent {
    kubernetes {
      label 'icecastexporter'
      yaml """
      apiVersion: v1 
      kind: Pod 
      metadata: 
        name: worker
      spec:
        containers: 
        - name: docker
          image: docker
          command: ['cat']
          tty: true
          env:
          - name: DOCKER_HOST 
            value: tcp://localhost:2375
        - name: docker-daemon 
          image: docker:dind
          securityContext: 
            privileged: true 
          volumeMounts: 
          - name: docker-graph-storage 
            mountPath: /var/lib/docker 
        volumes: 
        - name: docker-graph-storage 
          emptyDir: {}
      """
    }
  }

  environment {
    image = "${DOCKER_REGISTRY}/icecastexporter"
  }

  stages {
    stage('Build Image') {
      steps {
        container('docker') {
          withDockerRegistry(credentialsId: DOCKER_REGISTRY, url: "https://${DOCKER_REGISTRY}") {
            sh "docker build -t ${image}:latest ."
            sh "docker push ${image}:latest"
          }
        }
      }
    }
  }
}