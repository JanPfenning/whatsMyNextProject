<?php
class DOMValidator
{
    protected $feedSchema;
    public $feedErrors = 0;
    public $errorDetails;

    public function __construct($schemaPath)
    {
        $this->feedSchema = $schemaPath;
        $this->handler = new \DOMDocument('1.0', 'utf-8');
    }

    private function libxmlDisplayError($error)
    {
        $errorString = "Error $error->code in $error->file (Line:{$error->line}):";
        $errorString .= trim($error->message);
        return $errorString;
    }

    private function libxmlDisplayErrors()
    {
        $errors = libxml_get_errors();
        $result = [];
        foreach ($errors as $error) {
            $result[] = $this->libxmlDisplayError($error);
        }
        libxml_clear_errors();
        return $result;
    }

    public function validateFeeds($feeds)
    {
        if (!class_exists('DOMDocument')) {
            throw new \DOMException("'DOMDocument' class not found!");
            return false;
        }
        if (!file_exists($this->feedSchema)) {
            throw new \Exception('Schema is Missing, Please add schema to feedSchema property');
            return false;
        }
        libxml_use_internal_errors(true);
        if (!($fp = fopen($feeds, "r"))) {
            die("could not open XML input");
        }

        $contents = fread($fp, filesize($feeds));
        fclose($fp);

        $this->handler->loadXML($contents, LIBXML_NOBLANKS);
        if (!$this->handler->schemaValidate($this->feedSchema)) {
            $this->errorDetails = $this->libxmlDisplayErrors();
            $this->feedErrors   = 1;
        } else {
            //The file is valid
            return true;
        }
    }

    //Display Errors if some occured
    public function displayErrors()
    {
        return $this->errorDetails;
    }
}
?>