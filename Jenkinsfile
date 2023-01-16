#!/usr/bin/env groovy

def release = null
def app_version = null
def build = null
def new_release
def new_app_version
def new_build

pipeline {
    options {
        ansiColor('xterm')
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '2'))
    }

    parameters {
        string(name: 'tla', description: 'TLA to deploy, currently working for: sib,spb,fcq,sco,wlp,fbs,psa', defaultValue: 'tla')
        text(name: 'commit', description: 'Provide commit message', defaultValue: 'Manifest version was bumped to 1.0-2')
        string(name: 'tla_ver', description: 'TLA version to bump for the manifest', defaultValue: '1.0-2')
        string(name: 'manifest_ver', description: 'Manifest builder version to bump for the manifest, normally the same as tla_ver', defaultValue: '1.0-2')
        string(name: 'build_num', description: 'Build number to bump for the manifest', defaultValue: '2')
        string(name: 'product_branch', description: 'Branch of product_config repo to bump manifest version', defaultValue: 'master')
    }

    agent {
        label "linux"
    }

    stages {
        stage('Clone product config') {
            steps {
                script {
                    currentBuild.displayName = "${params.tla} - ${params.product_branch}-manifest"
                }
            }
        }
        stage('Get Manifest data') {
            steps {
                dir("./product/${params.tla}/inventory") {
                    sh "ls -ltr ${pwd()} && cat package.yml"
                    script {
                        release = sh(returnStdout: true, script: "awk -F: '/release:/ {print \$2}' package.yml").trim()
                        app_version = sh(returnStdout: true, script: "awk -F: '/application_version/ {print \$2}' package.yml").trim()
                        build = sh(returnStdout: true, script: "awk -F: '/build/ {print \$2}' package.yml").trim()
                        sh """
                            echo release: $release 
                            echo app_version: $app_version
                            echo build: $build
                        """
                    }    
                }
            }
        }
        stage('Bump Manifest version') {
            steps {
                dir("./product/${params.tla}/inventory") {
                    script {
                        new_release = sh(returnStdout: true, script: """sed -i "s|$release|${params.tla_ver}|g" package.yml""").trim()
                        new_app_version = sh(returnStdout: true, script: """sed -i "6 s|$app_version|${params.manifest_ver}|" package.yml""").trim()
                        new_build = sh(returnStdout: true, script: """sed -i "7 s|$build|${params.build_num}|" package.yml""").trim()
                    }
                    sh "ls -ltr ${pwd()} && cat package.yml"
                }
            }
        }
        stage('Commit and Publish') {
            steps {
                sh """
                    git config -l
                    git config --global user.email "jenkins@example.com"
                    git config --global user.name "jenkins"
                    git config -l
                    git branch
                    git checkout -b ${params.product_branch}
                    git branch
                    git status 
                    git commit -am "${params.commit}"
                    git status
                """
            }
        }
    }

    post {
        success {
            echo "Manifest version was bumped to $tla-$tla_ver with build number $build_num"
        }
        always {
            cleanWs()
        }
    }
}
