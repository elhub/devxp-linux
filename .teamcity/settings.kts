import jetbrains.buildServer.configs.kotlin.v2019_2.DslContext
import jetbrains.buildServer.configs.kotlin.v2019_2.project
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.VcsTrigger
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.vcs
import jetbrains.buildServer.configs.kotlin.v2019_2.version
import no.elhub.devxp.build.configuration.CodeReview
import no.elhub.devxp.build.configuration.ProjectType
import no.elhub.devxp.build.configuration.PublishDocs
import no.elhub.devxp.build.configuration.SonarScan

version = "2022.04"

project {
    val projectName = "devxp-linux"
    val projectId = "no.elhub.devxp:$projectName"
    val projectType = ProjectType.ANSIBLE

    params {
        param("teamcity.ui.settings.readOnly", "true")
    }

    val sonarScanConfig = SonarScan.Config(
        vcsRoot = DslContext.settingsRoot,
        type = projectType,
        sonarId = projectId
    )

    val codeReview = CodeReview(
        CodeReview.Config(
            vcsRoot = DslContext.settingsRoot,
            type = projectType,
            sonarScanConfig = sonarScanConfig
        )
    )

    val sonarScan = SonarScan(sonarScanConfig){
        triggers {
            vcs {
                branchFilter = "+:<default>"
                quietPeriodMode = VcsTrigger.QuietPeriodMode.USE_DEFAULT
            }
        }
    }

    listOf(codeReview, sonarScan).forEach { buildType(it) }

}
