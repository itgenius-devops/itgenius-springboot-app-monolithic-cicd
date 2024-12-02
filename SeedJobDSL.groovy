import groovy.json.JsonSlurper

def pipelinesListFileName = 'pipelines_list.json'

// Read the pipelines list from JSON file
def projects = new JsonSlurper().parseText(new File("${WORKSPACE}", pipelinesListFileName).text)

// Loop through the projects and create pipelines
projects.each { project ->
    def pipelineName = project.name
    def repoUrl = project.repo
    def branch = project.branch
    def jenkinsfilePath = project.jenkinsfile
    def credentialsId = 'github_creds'

    // Create pipeline job
    pipelineJob(pipelineName) {
        definition {
            cpsScm {
                scm {
                    git {
                        remote {
                            url(repoUrl)
                            credentials(credentialsId)
                        }
                        branches(branch)
                        scriptPath(jenkinsfilePath)
                    }
                }
            }
        }
    }
}