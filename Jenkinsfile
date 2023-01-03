pipeline {
	agent any
	stages {
		stage("Compile") {
			steps {
				dir("calculator"){
					sh "JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64" mvn compile"
				}
			}
		}
		stage("Unit test") {
			steps { 
				dir("calculator"){
					JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64" mvn compile
				}
			}
		}
	}
}
