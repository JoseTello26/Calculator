pipeline {
	agent any
	stages {
		stage("Compile") {
			steps {
				dir("calculator"){
					sh "JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' mvn compile"
				}
			}
		}
		stage("Unit test") {
			steps { 
				dir("calculator"){
					sh "JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' mvn test"
				}
			}
		}
		stage("Code coverage") {
			steps {
				publishHTML (target: [
					reportDir: 'calculator/target/site/jacoco',
					reportFiles: 'index.html',
					reportName:"JaCoCo Report"
				])
			}
		}
		stage("Static code analysis") {
			steps {
				dir("calculator"){
					sh "JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' mvn checkstyle:checkstyle"
				}
				publishHTML (target: [
					reportDir: 'calculator/target/site',
					reportFiles: 'checkstyle.html',
					reportName:"Checkstyle Report"
				])
			}
		}

	}
	post {
		always {
			mail to: 'jose.tello.l@uni.pe',
			subject:"Completed Pipeline: ${currentBuild.fullDisplayName}",
			body:"Your build completed, please check: ${env.BUILD_URL}"
		}
	}
}
