import jetbrains.buildServer.configs.kotlin.v2019_2.DslContext
import jetbrains.buildServer.configs.kotlin.v2019_2.buildFeatures.SshAgent
import jetbrains.buildServer.configs.kotlin.v2019_2.project
import jetbrains.buildServer.configs.kotlin.v2019_2.sequential
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.VcsTrigger
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.vcs
import jetbrains.buildServer.configs.kotlin.v2019_2.version
import no.elhub.common.build.configuration.AutoRelease
import no.elhub.common.build.configuration.CodeReview
import no.elhub.common.build.configuration.ProjectType
import no.elhub.common.build.configuration.PublishDocs
import no.elhub.common.build.configuration.SonarScan
import no.elhub.common.build.configuration.constants.GlobalTokens

version = "2022.04"

project {

    val projectId = "no.elhub.devxp:devxp-linux"
    val projectType = ProjectType.ANSIBLE
    val artifactoryRepository = "elhub-bin-release-local"

    params {
        param("teamcity.ui.settings.readOnly", "true")
    }

    val sonarScanConfig = SonarScan.Config(
        vcsRoot = DslContext.settingsRoot,
        type = projectType,
        sonarId = projectId
    )

    val buildChain = sequential {

        buildType(
            SonarScan(sonarScanConfig)
        )

        val githubAuth = SshAgent({
            teamcitySshKey = "teamcity_github_rsa"
            param("secure:passphrase", GlobalTokens.githubSshPassphrase)
        })

        buildType(
            AutoRelease(
                AutoRelease.Config(
                    vcsRoot = DslContext.settingsRoot,
                    type = projectType,
                    sshAgent = githubAuth
                )
            ) {
                triggers {
                    vcs {
                        branchFilter = "+:<default>"
                        quietPeriodMode = VcsTrigger.QuietPeriodMode.USE_DEFAULT
                    }
                }
            })

        buildType(
            PublishDocs(
                PublishDocs.Config(
                    vcsRoot = DslContext.settingsRoot,
                    type = projectType,
                    dest = "devxp/devxp-linux"
                )
            ) {
                triggers {
                    vcs {
                        branchFilter = "+:<default>"
                        quietPeriodMode = VcsTrigger.QuietPeriodMode.USE_DEFAULT
                    }
                }
            })

    }

    buildChain.buildTypes().forEach { buildType(it) }

    buildType(
        CodeReview(
            CodeReview.Config(
                vcsRoot = DslContext.settingsRoot,
                type = projectType,
                sonarScanConfig = sonarScanConfig
            )
        )
    )

}
