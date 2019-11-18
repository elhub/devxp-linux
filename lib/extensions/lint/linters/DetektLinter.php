<?php

/**
 * Lints Kotlin source files using the "detekt" tool.
 */
final class DetektLinter extends ArcanistExternalLinter {

  private $config = null;

  public function getInfoName() {
    return 'Detekt Linter';
  }

  public function getInfoDescription() {
    return pht('Checks Kotlin files');
  }

  public function getInfoURI() {
    return 'https://github.com/arturbosch/detekt';
  }

  public function getLinterName() {
    return 'DETEKT';
  }

  public function getLinterConfigurationName() {
    return 'detekt';
  }

  public function getDefaultBinary() {
    return 'detekt';
  }

  public function getVersion() {
    return false;
  }

  public function getInstallInstructions() {
    return pht(
      'Build and install from the github repository.',
      'and create a script to run it.');
  }

  protected function getMandatoryFlags() {
    return array('-i');
  }

  protected function parseLinterOutput($path, $err, $stdout, $stderr) {
    $lines = phutil_split_lines($stdout, false);

    // [ERROR] /path/to/file.java:31: Message text [Indentation]
    // [WARN] /path/to/file.java:31:10: Message text [Indentation]
    $regex = '/^\s*(?P<type>.*) - \[(?P<message>.*)\] at (?P<path>.*):(?P<line>\d+):(?P<char>\d+)$/';
    $severity = 'WARN';
    $messages = array();
    foreach ($lines as $line) {
      $matches = null;
      if (preg_match($regex, $line, $matches)) {
        $message = new ArcanistLintMessage();
        $message->setPath($path);
        $message->setLine($matches['line']);
        if (!empty($matches['char'])) {
          $message->setChar($matches['char']);
        }
        $message->setCode($matches['type']);
        $message->setName($this->getLinterName());
        $message->setDescription($matches['message']);
        $message->setSeverity($this->getMatchSeverity($severity));
        $messages[] = $message;
      }
    }

    return $messages;
  }

  private function getMatchSeverity($name) {
    $map = array(
      'ERROR' => ArcanistLintSeverity::SEVERITY_ERROR,
      'WARN'  => ArcanistLintSeverity::SEVERITY_WARNING,
    );

    if (array_key_exists($name, $map)) {
       return $map[$name];
    }

    return ArcanistLintSeverity::SEVERITY_ERROR;
  }
}
