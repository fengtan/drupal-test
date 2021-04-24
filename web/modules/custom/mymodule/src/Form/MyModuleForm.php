<?php

namespace Drupal\mymodule\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * A dummy form.
 */
class MyModuleForm extends FormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'mymodule_form';
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $this->messenger()->addStatus($this->t(
      'Hello @username !',
      ['@username' => $this->currentUser()->getDisplayName()]
    ));

    $form['actions']['button'] = [
      '#type' => 'submit',
      '#value' => $this->t('Click me !'),
    ];

    $form['#attached']['library'][] = 'mymodule/mymodule';

    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    // Do nothing. The button of this form is used only for testing JS.
  }

}
