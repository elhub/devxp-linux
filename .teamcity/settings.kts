import jetbrains.buildServer.configs.kotlin.v2019_2.BuildType
import jetbrains.buildServer.configs.kotlin.v2019_2.DslContext
import jetbrains.buildServer.configs.kotlin.v2019_2.project
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.VcsTrigger
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.vcs
import jetbrains.buildServer.configs.kotlin.v2019_2.version

version = "2020.1"

project {
    params {
        param("teamcity.ui.settings.readOnly", "true")
    }

    val check = Config(
            id = "Build",
            name = "Build"
    )

    listOf(check).forEach { buildType(Build(it)) }
}

data class Config(
        val id: String,
        val name: String
)

class Build(config: Config) : BuildType({
    id(config.id)
    name = config.name

    vcs {
        root(DslContext.settingsRoot)
        cleanCheckout = true
    }

    steps {

        step {
            name = "Ansible Dry Run"
            type = "elinyo_ansible_runner"
            param("elinyo_ar_options", "--check")
            param("elinyo_ar_playbook_file", "install.yml")
        }

        step {
            name = "Sonar Scan"
            type = "sonar-plugin"
            param("sonarProjectSources", ".")
            param("sonarServer", "c2635de0-ee28-443d-b7df-a7aa80b0ded7")
        }

    }

    triggers {
        vcs {
            quietPeriodMode = VcsTrigger.QuietPeriodMode.USE_DEFAULT
        }
    }
})
