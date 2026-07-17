<?php

use NFePHP\Common\Certificate;

require __DIR__ . '/../vendor/autoload.php';

$config = [
    "atualizacao" => date('Y-m-d H:i:s'),
    "tpamb" => 2,
    "razaosocial" => "Empresa Teste",
    "siglaUF" => "SP",
    "cnpj" => "99999999999999",
    "schemes" => "PL_009_V4",
    "versao" => "4.00",
    "tokenIBPT" => "",
    "CSC" => "",
    "CSCid" => "",
    "aProxyConf" => [],
    "prefeitura" => "americana-sp"
];
$configJson = json_encode($config);

$content = file_get_contents(__DIR__ . '/expired_certificate.pfx');
$cert = Certificate::readPfx($content, 'associacao');

try {
    $tools = new \Hadder\NfseNacional\Tools($configJson, $cert);
    $response = $tools->consultarCancelamentoNfse('00000000000000000000000000000000000000000000000000');

    print_r($response);
} catch (\Exception $e) {
    echo $e->getMessage();
}
