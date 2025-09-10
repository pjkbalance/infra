<?php
/**
 * User-specific configuration for phpMyAdmin
 */

// Example: Allow login without password (not recommended for production)
$cfg['Servers'][1]['auth_type'] = 'cookie';

// Example: Host configuration
$cfg['Servers'][1]['host'] = getenv('DB_HOST') ?: '';
$cfg['Servers'][1]['port'] = getenv('DB_PORT') ?: '';

// Example: User configuration (leave empty for cookie auth)
$cfg['Servers'][1]['user'] = getenv('DB_USERNAME') ?: '';
$cfg['Servers'][1]['password'] = getenv('DB_PASSWORD') ?: '';

// Example: Enable advanced features
$cfg['Servers'][1]['AllowNoPassword'] = false;

// Example: Set default language
$cfg['DefaultLang'] = 'en';

// Example: Set default theme
$cfg['ThemeDefault'] = 'pmahomme';

// Add any other custom settings below