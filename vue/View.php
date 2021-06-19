<?php

class View
{
    private $file;
    private $msg;
    private $t;
    private $contentArray;
    private $msgError;

    public function __construct($action)
    {
        $this->file = 'vue/' . $action . ".tpl";
    }
    //genere et affiche la vue
    public function generate()
    {
        //partie spécifique de la vue

        $vueTemplate = explode("/", $this->file);
        $content = $this->generateFile($this->file);
        //template sans la partie spécifique content.
        $view = $this->generateFileData('vue/' . $vueTemplate[1] . '/template.tpl', array('t' => $this->t, 'content' => $content, 'msg'=>$this->msg,'msgError' => $this->msgError));
        echo $view;
    }
    //genere fichier et renvoie le resultat
    private function generateFile($file_)
    {
        if (file_exists($file_)) {
            ob_start();
            require $file_;

            return ob_get_clean();
        } else
            throw new Exception('Fichier ' . $file_ . ' introuvable');
    }

    private function generateFileData($file_, $data)
    {
        if (file_exists($file_)) {
            extract($data);
            ob_start();
            require $file_;

            return ob_get_clean();
        } else
            throw new Exception('Fichier ' . $file_ . ' introuvable');
    }
     public function setContentArray($contentArray)
    {
        $this->contentArray = $contentArray;
    }
    public function setMsgError($msg)
    {
        $this->msgError = $msg;
    }
    public function setMsg($msg)
    {
        $this->msg = $msg;
    }

}
