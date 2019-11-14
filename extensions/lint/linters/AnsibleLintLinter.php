<?php

/**
 * Uses "ansible-lint" to suggest improvements to Ansible playbooks.
 */
final class AnsibleLintLinter extends ArcanistExternalLinter {

    public function getInfoName() {
        return 'Ansible-Lint';
    }

    public function getInfoURI() {
        return 'https://pypi.python.org/pypi/ansible-lint';
    }

    public function getInfoDescription() {
        return pht(
            'Checks Ansible playbooks for practices and behavior '.
            'that could potentially be improved.');
    }

    public function getLinterName() {
        return 'ANSIBLE';
    }

    public function getLinterConfigurationName() {
        return 'ansible-lint';
    }

    public function getDefaultBinary() {
        return 'ansible-lint';
    }

    protected function getDefaultFlags() {
        return array(
            '-p', // parseable PEP8-format output
        );
    }

    public function getVersion() {
        list($stdout) = execx('%C --version', $this->getExecutableCommand());

        $matches = array();
        if (preg_match('/^ansible-lint (?P<version>\d+\.\d+(?:\.\d+)?)\b/',
            $stdout, $matches)) {
            return $matches['version'];
        } else {
            return false;
        }
    }

    public function getInstallInstructions() {
        return pht('Install ansible-lint using `%s`.', 'pip install ansible-lint');
    }

    protected function parseLinterOutput($path, $err, $stdout, $stderr) {
        $lines = phutil_split_lines($stdout, false);

        $messages = array();
        foreach ($lines as $line) {
            $matches = null;
            if (!preg_match('/^(.*?):(\d+): (\S+) (.*)$/', $line, $matches)) {
                continue;
            }
            foreach ($matches as $key => $match) {
                $matches[$key] = trim($match);
            }
            $message = new ArcanistLintMessage();
            $message->setPath($matches[1]);
            $message->setLine($matches[2]);
            $message->setCode($matches[3]);
            $message->setName('Ansible-Lint '.$matches[3]);
            $message->setDescription($matches[4]);
            $message->setSeverity($this->getLintMessageSeverity($matches[3]));
            $messages[] = $message;
        }

        return $messages;
    }

    protected function getDefaultMessageSeverity($code) {
        if (preg_match('/^ANSIBLE0003$/', $code)) {
            return ArcanistLintSeverity::SEVERITY_ERROR;
        } else {
            return ArcanistLintSeverity::SEVERITY_WARNING;
        }
    }

    protected function getLintCodeFromLinterConfigurationKey($code) {
        if (!preg_match('/^(ANSIBLE)\d+$/', $code)) {
            throw new Exception(
                pht(
                    'Unrecognized lint message code "%s". Expected a valid Ansible-Lint '.
                    'lint code like "%s" or "%s".',
                    $code,
                    'ANSIBLE0002',
                    'ANSIBLE0007'));
        }

        return $code;
    }

}
