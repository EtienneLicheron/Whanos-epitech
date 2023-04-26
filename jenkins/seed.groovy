folder("whanos-base-images") {
    displayName('Whanos base images')
    description('Base images for Whanos')
}

freeStyleJob("link-project") {
    displayName('Link project')
    description('Link project to Jenkins')
    parameters {
        stringParam('REPOSITORY_URL', '', 'Link to repository')
        stringParam('PROJECT_NAME', '', 'Name of project')
    }
    steps {
        dsl {
            text("""
                freeStyleJob("Projects/\$PROJECT_NAME") {
                    displayName("\$PROJECT_NAME")
                    description("Project \$PROJECT_NAME")
                    steps {
                        shell(readFileFromWorkspace('../../deploy.sh'))
                    }
                    scm {
                        git {
                            remote {
                                url("\$REPOSITORY_URL")
                            }
                        }
                    }
                    triggers {
                        scm('* * * * *')
                    }
                    environmentVariables {
                        env("REPOSITORY_URL", "\$REPOSITORY_URL")
                        env("PROJECT_NAME", "\$PROJECT_NAME")
                    }
                }""".stripIndent())
        }
    }
}

folder("Projects") {
}
