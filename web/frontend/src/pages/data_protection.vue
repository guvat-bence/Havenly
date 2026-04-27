<template>
  <div class="data_protection">
    <div class="container py-5 text-white">

      <!-- Cím -->
      <h1 class="display-3 text-white text-center mb-4">
        {{ $t('data_protection.data_protection_title') }}
      </h1>

      <!-- Bevezető -->
      <div class="mb-4">
        <p>{{ $t('data_protection.data_protection_text_first') }}</p>
        <p>{{ $t('data_protection.data_protection_text_second') }}</p>
      </div>

      <!-- 1. Adatkezelő -->
      <div class="mb-4">
        <h2>{{ $t('data_protection.data_controller_datas.data_controller_datas_title') }}</h2>
        <p>
          <strong>{{ $t('data_protection.data_controller_datas.data_controller_name_title') }}</strong>
          {{ $t('data_protection.data_controller_datas.data_controller_name') }}
        </p>
        <p>
          <strong>{{ $t('data_protection.data_controller_datas.project_type_title') }}:</strong>
          {{ $t('data_protection.data_controller_datas.project_type') }}
        </p>
        <p>
          <strong>{{ $t('data_protection.data_controller_datas.contact_title') }}:</strong>
        </p>
      </div>

      <!-- 2. Kezelt adatok -->
      <div class="mb-4">
        <h2>{{ $t('data_protection.privacy_information.privacy_information_title') }}</h2>

        <h5 class="mt-3">
          {{ $t('data_protection.privacy_information.registration_datas.registration_datas_title') }}
        </h5>
        <ul>
          <li>{{ $t('data_protection.privacy_information.registration_datas.full_name') }}</li>
          <li>{{ $t('data_protection.privacy_information.registration_datas.email') }}</li>
          <li>{{ $t('data_protection.privacy_information.registration_datas.phone_number') }}</li>
          <li>{{ $t('data_protection.privacy_information.registration_datas.password') }}</li>
        </ul>

        <h5 class="mt-3">
          {{ $t('data_protection.privacy_information.profile_datas.profile_datas_title') }}
        </h5>
        <ul>
          <li>{{ $t('data_protection.privacy_information.profile_datas.adress') }}</li>
          <li>{{ $t('data_protection.privacy_information.profile_datas.paying_methods') }}</li>
          <li>{{ $t('data_protection.privacy_information.profile_datas.bank_card_datas') }}</li>
        </ul>

        <h5 class="mt-3">
          {{ $t('data_protection.privacy_information.accommodations_datas.accommodations_datas_title') }}
        </h5>
        <ul>
          <li>{{ $t('data_protection.privacy_information.accommodations_datas.accommodation_addres') }}</li>
          <li>{{ $t('data_protection.privacy_information.accommodations_datas.description') }}</li>
          <li>{{ $t('data_protection.privacy_information.accommodations_datas.pictures') }}</li>
          <li>{{ $t('data_protection.privacy_information.accommodations_datas.prices_and_renting') }}</li>
        </ul>

        <h5 class="mt-3">
          {{ $t('data_protection.privacy_information.renting_datas.renting_datas_title') }}
        </h5>
        <ul>
          <li>{{ $t('data_protection.privacy_information.renting_datas.renting_time') }}</li>
          <li>{{ $t('data_protection.privacy_information.renting_datas.renter_and_owner_datas') }}</li>
          <li>{{ $t('data_protection.privacy_information.renting_datas.payment_informations') }}</li>
        </ul>

        <h5 class="mt-3">
          {{ $t('data_protection.privacy_information.communication_datas.communication_datas_title') }}
        </h5>
        <ul>
          <li>{{ $t('data_protection.privacy_information.communication_datas.communication') }}</li>
          <li>{{ $t('data_protection.privacy_information.communication_datas.metedatas') }}</li>
        </ul>

        <h5 class="mt-3">
          {{ $t('data_protection.privacy_information.tech_datas.tech_datas') }}
        </h5>
        <ul>
          <li>{{ $t('data_protection.privacy_information.tech_datas.ip_addres') }}</li>
          <li>{{ $t('data_protection.privacy_information.tech_datas.browser_type') }}</li>
          <li>{{ $t('data_protection.privacy_information.tech_datas.log_in_times') }}</li>
        </ul>
      </div>

      <!-- 3. Cél -->
      <div class="mb-4">
        <h4>{{ $t('data_protection.data_controlling_goal.data_controlling_goal_title') }}</h4>
        <ul>
          <li>{{ $t('data_protection.data_controlling_goal.user_profile') }}</li>
          <li>{{ $t('data_protection.data_controlling_goal.renting') }}</li>
          <li>{{ $t('data_protection.data_controlling_goal.experiences_and_accommodations') }}</li>
          <li>{{ $t('data_protection.data_controlling_goal.payment') }}</li>
          <li>{{ $t('data_protection.data_controlling_goal.communications') }}</li>
          <li>{{ $t('data_protection.data_controlling_goal.webiste_working') }}</li>
          <li>{{ $t('data_protection.data_controlling_goal.scams') }}</li>
          <li>{{ $t('data_protection.data_controlling_goal.policy') }}</li>
        </ul>
      </div>

      <!-- 4. Jogalap -->
      <div class="mb-4">
        <h4>{{ $t('data_protection.data_controlling_policy.data_controlling_policy_title') }}</h4>
        <ul>
          <li>{{ $t('data_protection.data_controlling_policy.user_agree') }}</li>
          <li>{{ $t('data_protection.data_controlling_policy.contract') }}</li>
          <li>{{ $t('data_protection.data_controlling_policy.law') }}</li>
          <li>{{ $t('data_protection.data_controlling_policy.law2') }}</li>
        </ul>
      </div>

      <!-- 5. Tárolás -->
      <div class="mb-4">
        <h4>{{ $t('data_protection.data_storeing.data_storeing_title') }}</h4>
        <ul>
          <li>{{ $t('data_protection.data_storeing.user_datas') }}</li>
          <li>{{ $t('data_protection.data_storeing.renting_datas') }}</li>
          <li>{{ $t('data_protection.data_storeing.messages') }}</li>
          <li>{{ $t('data_protection.data_storeing.tech_datas') }}</li>
        </ul>
      </div>

      <!-- 6. Továbbítás -->
      <div class="mb-4">
        <h4>{{ $t('data_protection.data_forwarding.data_forwarding_title') }}</h4>
        <p>{{ $t('data_protection.data_forwarding.intro') }}</p>
        <ul>
          <li>{{ $t('data_protection.data_forwarding.payment_providers') }}</li>
          <li>{{ $t('data_protection.data_forwarding.hosting_provider') }}</li>
          <li>{{ $t('data_protection.data_forwarding.email_provider') }}</li>
          <li>{{ $t('data_protection.data_forwarding.analytics') }}</li>
        </ul>
        <p>{{ $t('data_protection.data_forwarding.minimal_data') }}</p>
      </div>

      <!-- 7. Jogok -->
      <div class="mb-4">
        <h4>{{ $t('data_protection.user_rights.user_rights_title') }}</h4>
        <ul>
          <li>{{ $t('data_protection.user_rights.access') }}</li>
          <li>{{ $t('data_protection.user_rights.correction') }}</li>
          <li>{{ $t('data_protection.user_rights.deletion') }}</li>
          <li>{{ $t('data_protection.user_rights.restriction') }}</li>
          <li>{{ $t('data_protection.user_rights.portability') }}</li>
          <li>{{ $t('data_protection.user_rights.withdraw_consent') }}</li>
          <li>{{ $t('data_protection.user_rights.complaint') }}</li>
        </ul>
      </div>

      <!-- 8. Biztonság -->
      <div class="mb-4">
        <h4>{{ $t('data_protection.data_security.data_security_title') }}</h4>
        <p>{{ $t('data_protection.data_security.intro') }}</p>
        <ul>
          <li>{{ $t('data_protection.data_security.https') }}</li>
          <li>{{ $t('data_protection.data_security.password_hash') }}</li>
          <li>{{ $t('data_protection.data_security.backups') }}</li>
          <li>{{ $t('data_protection.data_security.permissions') }}</li>
          <li>{{ $t('data_protection.data_security.abuse_monitoring') }}</li>
        </ul>
      </div>

      <!-- 9. Módosítás -->
      <div class="mb-4">
        <h4>{{ $t('data_protection.privacy_policy_modification.privacy_policy_modification_title') }}</h4>
        <p>
          {{ $t('data_protection.privacy_policy_modification.modification_text') }}
          {{ $t('data_protection.privacy_policy_modification.notification') }}
        </p>
      </div>

    </div>
  </div>
</template>
