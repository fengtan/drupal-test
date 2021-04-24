<?php

namespace Drupal\Tests\mymodule\Functional;

use Drupal\Tests\BrowserTestBase;

/**
 * Test basic functionality of My Custom Module.
 *
 * @group mymodule
 */
class MyBasicTest extends BrowserTestBase {

  /**
   * {@inheritdoc}
   */
  protected $defaultTheme = 'stark';

  /**
   * {@inheritdoc}
   */
  public static $modules = ['mymodule'];

  /**
   * Test mymodule shows a dummy page at /mymodule.
   */
  public function testHello() {
    $user = $this->drupalCreateUser(['access content']);
    $this->drupalLogin($user);
    $this->drupalGet('mymodule');
    $this->assertSession()->statusCodeEquals(200);
    $this->assertText('Hello');
  }

}
