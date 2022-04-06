<?php

declare(strict_types=1);

$module = new Pkcs11\Module(getenv('PHP11_MODULE'));
$session = $module->openSession((int)getenv('PHP11_SLOT'), Pkcs11\CKF_RW_SESSION);
$session->login(Pkcs11\CKU_USER, getenv('PHP11_PIN'));

$skey = $session->findObjects([
	Pkcs11\CKA_CLASS => Pkcs11\CKO_PRIVATE_KEY
])[0];

$mechanism = new Pkcs11\Mechanism(Pkcs11\CKM_SHA256_RSA_PKCS);

$data = file_get_contents('php://input');
$signature = $skey->sign($mechanism, $data);
$session->logout();

echo base64_encode($signature);
