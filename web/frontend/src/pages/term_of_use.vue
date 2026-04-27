<template>
  <div class="terms_of_use"> 
    <div class="container py-5 text-white">

      <!-- Cím -->
      <h1 class="display-5 text-white text-center mb-4">
        {{ $t("term_of_use.title") }}
      </h1>

      <!-- Bevezető -->
      <div class="mb-4">
        <p>{{ $t("term_of_use.intro.description_1") }}</p>
        <p>{{ $t("term_of_use.intro.description_2") }}</p>
      </div>

      <!-- 1. A szolgáltatás jellege -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.service_nature.service_nature_title") }}</h2>
        <p>{{ $t("term_of_use.service_nature.intro") }}</p>
        <ul>
          <li>{{ $t("term_of_use.service_nature.features.browse_booking") }}</li>
          <li>{{ $t("term_of_use.service_nature.features.property_upload") }}</li>
          <li>{{ $t("term_of_use.service_nature.features.experiences") }}</li>
          <li>{{ $t("term_of_use.service_nature.features.messaging") }}</li>
          <li>{{ $t("term_of_use.service_nature.features.profile") }}</li>
          <li>{{ $t("term_of_use.service_nature.features.payments") }}</li>
        </ul>
        <p>{{ $t("term_of_use.service_nature.education_note") }}</p>
      </div>

      <!-- 2. Regisztráció -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.registration_account.registration_account_title") }}</h2>
        <p>{{ $t("term_of_use.registration_account.requirements_intro") }}</p>
        <ul>
          <li>{{ $t("term_of_use.registration_account.requirements.real_data") }}</li>
          <li>{{ $t("term_of_use.registration_account.requirements.valid_contact") }}</li>
          <li>{{ $t("term_of_use.registration_account.requirements.secure_password") }}</li>
        </ul>
        <p>{{ $t("term_of_use.registration_account.responsibility") }}</p>
      </div>

      <!-- 3. Kötelezettségek -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.user_obligations.user_obligations_title") }}</h2>
        <p>{{ $t("term_of_use.user_obligations.intro") }}</p>
        <ul>
          <li>{{ $t("term_of_use.user_obligations.rules.legal_use") }}</li>
          <li>{{ $t("term_of_use.user_obligations.rules.truthful_content") }}</li>
          <li>{{ $t("term_of_use.user_obligations.rules.personal_rights") }}</li>
          <li>{{ $t("term_of_use.user_obligations.rules.copyright") }}</li>
          <li>{{ $t("term_of_use.user_obligations.rules.system_integrity") }}</li>
        </ul>
        <p>{{ $t("term_of_use.user_obligations.sanctions") }}</p>
      </div>

      <!-- 4. Szállások -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.property_responsibility.property_responsibility_title") }}</h2>
        <p>{{ $t("term_of_use.property_responsibility.host_intro") }}</p>
        <ul>
          <li>{{ $t("term_of_use.property_responsibility.host_duties.accurate_data") }}</li>
          <li>{{ $t("term_of_use.property_responsibility.host_duties.legal_media") }}</li>
          <li>{{ $t("term_of_use.property_responsibility.host_duties.availability") }}</li>
          <li>{{ $t("term_of_use.property_responsibility.host_duties.timely_response") }}</li>
        </ul>
        <p>{{ $t("term_of_use.property_responsibility.disclaimer") }}</p>
      </div>

      <!-- 5. Foglalások -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.bookings_cancellations.bookings_cancellations_title") }}</h2>
        <p>{{ $t("term_of_use.bookings_cancellations.booking_process_title") }}</p>
        <ul>
          <li>{{ $t("term_of_use.bookings_cancellations.booking_process.select") }}</li>
          <li>{{ $t("term_of_use.bookings_cancellations.booking_process.check") }}</li>
          <li>{{ $t("term_of_use.bookings_cancellations.booking_process.confirmation") }}</li>
        </ul>

        <p>{{ $t("term_of_use.bookings_cancellations.cancellation_title") }}</p>
        <ul>
          <li>{{ $t("term_of_use.bookings_cancellations.cancellation_rules.guest_rules") }}</li>
          <li>{{ $t("term_of_use.bookings_cancellations.cancellation_rules.host_rights") }}</li>
        </ul>

        <p>{{ $t("term_of_use.bookings_cancellations.refunds") }}</p>
      </div>

      <!-- 6. Fizetések -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.payments.payments_title") }}</h2>
        <p>{{ $t("term_of_use.payments.payment_info") }}</p>
        <p>{{ $t("term_of_use.payments.no_liability_intro") }}</p>
        <ul>
          <li>{{ $t("term_of_use.payments.no_liability.provider_errors") }}</li>
          <li>{{ $t("term_of_use.payments.no_liability.declined_transactions") }}</li>
          <li>{{ $t("term_of_use.payments.no_liability.incorrect_data") }}</li>
        </ul>
      </div>

      <!-- 7. Üzenetküldés -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.messaging.messaging_title") }}</h2>
        <p>{{ $t("term_of_use.messaging.rules") }}</p>
        <p>{{ $t("term_of_use.messaging.monitoring") }}</p>
      </div>

      <!-- 8. Felelősség -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.liability_limitation.liability_limitation_title") }}</h2>
        <p>{{ $t("term_of_use.liability_limitation.no_liability_intro") }}</p>
        <ul>
          <li>{{ $t("term_of_use.liability_limitation.no_liability.downtime") }}</li>
          <li>{{ $t("term_of_use.liability_limitation.no_liability.user_content") }}</li>
          <li>{{ $t("term_of_use.liability_limitation.no_liability.property_quality") }}</li>
          <li>{{ $t("term_of_use.liability_limitation.no_liability.disputes") }}</li>
          <li>{{ $t("term_of_use.liability_limitation.no_liability.booking_errors") }}</li>
        </ul>
        <p>{{ $t("term_of_use.liability_limitation.own_risk") }}</p>
      </div>

      <!-- 9. Módosítás -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.service_modification.service_modification_title") }}</h2>
        <p>{{ $t("term_of_use.service_modification.modification_right") }}</p>
        <p>{{ $t("term_of_use.service_modification.notification") }}</p>
      </div>

      <!-- 10. Kapcsolat -->
      <div class="mb-4">
        <h2>{{ $t("term_of_use.contact.contact_title") }}</h2>
        <p>{{ $t("term_of_use.contact.contact_text") }}</p>
      </div>

    </div>
  </div>
</template>
