import { Questionnaire } from '@/types/questionnaire';

// For Tailwind styling with grid layout
const HALF_ROW = 6;
const FULL_ROW = 12;

export const questionnaire: Questionnaire = {
  title: 'Risk Management Survey',
  description:
    'This survey is designed to help us understand the risk management practices of the property ownership group.',
  sections: [
    {
      title: 'General Information',
      components: [
        {
          key: 'account_general_info',
          type: 'text',
          label: 'Account:',
          required: true,
          span: HALF_ROW,
        },
        {
          key: 'date_of_survey',
          type: 'date',
          label: 'Date of Survey:',
          required: true,
          span: HALF_ROW,
        },
        {
          key: 'policy_number',
          type: 'text',
          label: 'Policy Number:',
          span: HALF_ROW,
        },
        {
          key: 'representative',
          type: 'text',
          label: 'Representative:',
          required: true,
          span: HALF_ROW,
        },
        {
          key: 'insured',
          type: 'text',
          label: 'Insured:',
          span: HALF_ROW,
        },
        {
          key: 'person_interviewed_title',
          type: 'text',
          label: 'Person Interviewed & Title:',
          span: HALF_ROW,
        },
        {
          key: 'location',
          type: 'textarea',
          label: 'Location:',
          span: HALF_ROW,
        },
        {
          key: 'broker',
          type: 'text',
          label: 'Broker:',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Narrative',
      components: [
        {
          key: 'disclaimer',
          type: 'textarea',
          label: 'narrative',
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Operations/Risk Management',
      description:
        '*Calls for additional data/descriptions and most "No" responses require a "Comment"',
      components: [
        {
          key: 'is_address_inspected',
          type: 'radio',
          label:
            '1. Is address inspected the same as on the order request (if No, what is the address as inspected)?',
          options: [
            { label: 'yes', value: 'Yes' },
            {
              label: 'no',
              value: 'No',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_address_inspected_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'no_of_buildings',
          type: 'number',
          label: '2. # of buildings?',
          span: HALF_ROW,
        },
        {
          key: 'no_of_buildings_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'no_of_units',
          type: 'number',
          label: '3. # of units?',

          span: HALF_ROW,
        },
        {
          key: 'no_of_units_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'no_of_vacant_unit',
          type: 'number',
          label: '4. # of vacant units?',

          span: HALF_ROW,
        },
        {
          key: 'no_of_vacant_unit_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'no_of_units_designated_section_eight',
          type: 'number',
          label: '5. % of units designated Section 8?',

          span: HALF_ROW,
        },
        {
          key: 'no_of_units_designated_section_eight_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'no_of_units_designated_section_fortytwo',
          type: 'number',
          label: '6. % of units designated Section 42?',

          span: HALF_ROW,
        },
        {
          key: 'no_of_units_designated_section_fortytwo_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'no_of_units_occupied_by_students',
          type: 'number',
          label: '7. % of units occupied by students?',

          span: HALF_ROW,
        },
        {
          key: 'no_of_units_occupied_by_students_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'individual_with_explicit_responsibility_for_risk_management',
          type: 'radio',
          label:
            '8. Is there an individual with explicit responsibility for risk management within the property ownership group?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'individual_with_explicit_responsibility_for_risk_management_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'onsite_property_managment_during_business_hours',
          type: 'radio',
          label:
            '9. Is there on-site property management during business hours at least?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],

          span: HALF_ROW,
        },
        {
          key: 'onsite_property_managment_during_business_hours_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'preventative_measures_does_the_insured_take_to_prepare_for_forecasted_freezing_temperature',
          type: 'text',
          label:
            '10. What preventative measures does the insured take to prepare for forecasted freezing temperatures?',

          span: HALF_ROW,
        },
        {
          key: 'preventative_measures_does_the_insured_take_to_prepare_for_forecasted_freezing_temperature_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'preventative_measures_does_the_insured_take_to_prepare_for_forecasted_severe_wind_stroms',
          type: 'text',
          label:
            '11. What preventative measures does the insured take to prepare for forecasted severe wind storms?',
          span: HALF_ROW,
        },
        {
          key: 'preventative_measures_does_the_insured_take_to_prepare_for_forecasted_severe_wind_stroms_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'is_on_site_management_trained',
          type: 'radio',
          label:
            '12. Is on-site management trained in shutting off water to individual buildings and units in event of emergency?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],

          span: HALF_ROW,
        },
        {
          key: 'is_on_site_management_trained_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'is_there_a_method_for_tenants_to_report_emergency',
          type: 'radio',
          label:
            '13. Is there a method for tenants to report emergency property damage situations to management after hours (If Yes, please describe)?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_there_a_method_for_tenants_to_report_emergency_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'are_occupied_units_inspected',
          type: 'radio',
          label: '14. Are occupied units inspected (if Yes, on what cadence)?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_occupied_units_inspected_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'is_smoking_prohibited_in_all_units',
          type: 'radio',
          label: '15. Is smoking prohibited in all units? ',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_smoking_prohibited_in_all_units_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'how_often_does_an_employee_inspect_vacant_unit',
          type: 'radio',
          label: '16. How often does an employee inspect a vacant unit?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'how_often_does_an_employee_inspect_vacant_unit_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        //TODO: add question 17 here ---> need to discusss it first
        {
          key: 'does_insured_always_use_contract_when_hiring',
          type: 'radio',
          label:
            '18. If not a standing contract, does the insured always use a contract when hiring a third party for work performed on the premises? ',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_insured_always_use_contract_when_hiring_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'does_insured_obtain_and_track_certificates',
          type: 'radio',
          label:
            '19. Does the insured obtain and track certificates of insurance (COIs) for contractors working on the premises?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_insured_obtain_and_track_certificates_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'minimum_limits_of_liability',
          type: 'text',
          label:
            '20. If Yes to the above, what are the minimum limits of liability insurance that the complex will accept?',
          span: HALF_ROW,
        },
        {
          key: 'minimum_limits_of_liability_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'risk_grades',
          type: 'text',
          label:
            '21. If risk includes an indoor parking garage, is it below grade, partially atgrade, fully at or above grade or free-standing?',
          span: HALF_ROW,
        },
        {
          key: 'risk_grades_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'is_parking_garage_operated_by_insured_and_for_the_sole_use_of_tenants',
          type: 'radio',
          label:
            '22. Is parking garage operated by the insured and for the sole use of tenants (if No, provide details, including the name of the company, the # of spaces, whether it is self or attendant parking, etc.)?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_parking_garage_operated_by_insured_and_for_the_sole_use_of_tenants_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'are_renovations_in_progress',
          type: 'radio',
          label: '23. Are renovations in progress? ',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_renovations_in_progress_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_observed_illegal_subdivisions',
          type: 'radio',
          label:
            '24. Risk free of observed/reported illegal subdivisions, e.g. illegal conversions of apartments into multiple SRO units (if No, FULLY detail)?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_observed_illegal_subdivisions_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'number_of_years_the_insured_has_owned_the_complex',
          type: 'text',
          label:
            '25. Number of years the insured has owned the complex (if a tenant, so state e.g. "Tenant-7 years")?',

          span: HALF_ROW,
        },
        {
          key: 'number_of_years_the_insured_has_owned_the_complex_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'does_risk_appear_well_managed_and_successfully_operated',
          type: 'radio',
          label:
            '26. Does risk appear well-managed & successfully operated (if No, detail why)?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_risk_appear_well_managed_and_successfully_operated_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'what_portion_is_vacant_and_for_how_long',
          type: 'text',
          label:
            '27. If all or part of the property is vacant, what portion is vacant and for how long? ',

          span: HALF_ROW,
        },
        {
          key: 'what_portion_is_vacant_and_for_how_long_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'does_insured_have_any_plans_for_vacant_area',
          type: 'radio',
          label:
            '28. Does the insured have any plans for the vacant area (if Yes, explain, including timetable for future occupancy)? ',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_insured_have_any_plans_for_vacant_area_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'is_there_laundry_room',
          type: 'radio',
          label:
            '29. Is there a laundry room (if Yes, are washers & dryers provided & maintained by the insured or by an outside contractor, the name of which is typically on the machines, indicating whom to call for servicing or other problems)?',
          options: [
            { label: 'In-house ', value: 'in_house' },
            {
              label: 'Outside contractor',
              value: 'outside_contractor',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_there_laundry_room_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'does_laundry_room_have_posted_hours',
          type: 'radio',
          label: '30. Does laundry room have posted hours?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_laundry_room_have_posted_hours_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'does_any_commercial_cooking_take_place_within_the_complex',
          type: 'radio',
          label:
            '31. Does any commercial cooking take place within the complex (if Yes, please elaborate and complete the Commercial Cooking sections below)? ',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_any_commercial_cooking_take_place_within_the_complex_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'do_the_lease_terms_restict_tenants_from_using_their_kitchen',
          type: 'radio',
          label:
            '32. Do the lease terms restrict tenants from using their kitchen (or any clubhouse area) for commercial cooking?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'do_the_lease_terms_restict_tenants_from_using_their_kitchen_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'does_managment_monitor_for_shut_down',
          type: 'radio',
          label:
            '33. Does management monitor for/shut down ???pop-up restaurants??? or  ghost kitchen type activity within the complex?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_managment_monitor_for_shut_down_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'was_access_provided_to_all_required_areas',
          type: 'radio',
          label:
            '34. Was access provided to all required areas, including flat rooftop, if any (if No, explain)?',
          options: [
            { label: 'Yes', value: 'yes' },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'was_access_provided_to_all_required_areas_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Losses',
      description: "Calls for additional data/description require a 'Comment'",
      components: [
        {
          key: 'have_insured_had_any_losses_of_any_type',
          type: 'radio',
          label:
            '1. Have the insured had any losses of any type within the past five years (if Yes, explain)?',
          options: [
            { label: 'Yes (explain)', value: 'yes_explain' },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'U/D',
              value: 'ud',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'have_insured_had_any_losses_of_any_type_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'for_losses_over_50000_please_explain',
          type: 'text',
          label:
            '2. For losses over $50,000, please explain what happened and management response/lessonslearned:',

          span: HALF_ROW,
        },
        {
          key: 'for_losses_over_50000_please_explain_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'named_source_for_loss_histoy_info',
          type: 'text',
          label:
            '3. Named source/tenure for loss history info (e.g. John Smith, super for past 10 yrs.)?',

          span: HALF_ROW,
        },
        {
          key: 'named_source_for_loss_histoy_info_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
      ],
    },
    {
      title:
        'Construction (as needed, Duplicate, Label & Complete for EACH building)',
      description: 'Calls for additional data/descriptions require a "Comment"',
      components: [
        {
          key: 'construction_type',
          type: 'checkbox',
          label:
            '1. Construction Type (if mixed construction, check all that apply and give percentage of each):',
          options: [
            {
              label: 'Frame (ISO I)',
              value: 'frame',
            },
            { label: 'Joisted Masonry (ISO II)', value: 'joisted_masonry' },
            {
              label: 'Non-combustible (ISO III)',
              value: 'non_combustible',
            },
            {
              label: 'Masonry Non-combustible (ISO IV)',
              value: 'masonry_non_combustible',
            },
            {
              label: 'Modified fire-resistive (ISO V)',
              value: 'modified_fire_resistive',
            },
            { label: 'Fire-resistive (ISO VI)', value: 'fire_resistive ' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'construction_type_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'brick_veneer',
          type: 'radio',
          label:
            '2. Brick (or stone) veneer (If Yes, MUST INCLUDE A CLOSE-UP EXTERIOR PHOTO, showing the pattern of the brick, as well as AN ADDITIONAL INTERIOR PHOTO, showing the tape-measured depth of the window and/or door opening)?',
          options: [
            {
              label: 'Yes (close-up photos required)',
              value: 'yes',
            },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'brick_veneer_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'load_bearing_substrate_behind_the_brick_vaneer',
          type: 'radio',
          label: '3. Load-bearing substrate behind the brick veneer?',
          options: [
            {
              label:
                'Plywood or other combustible sheathing nailed to wood studs',
              value: 'plawook_or_other_combustible',
            },
            { label: 'Concrete block', value: 'concrete_blocks' },
            { label: 'Other (describe)', value: 'other' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'load_bearing_substrate_behind_the_brick_vaneer_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'type_of_stucco',
          type: 'radio',
          label:
            '4. Type of stucco, if any (if building is stuccoclad, include CLOSE-UP INTERIOR PHOTOS showing the depth of window and/or door openings)?',
          options: [
            {
              label: 'Traditional (hard stucco) ',
              value: 'traditional_hard_stucci',
            },
            { label: 'Concrete block', value: 'concrete_blocks' },
            {
              label: 'EIFS (stucco applied over foam board)',
              value: 'stucco_applied_over_foam_board',
            },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'type_of_stucco_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'is_it_face_sealed',
          type: 'radio',
          label:
            '5. If EIFS-clad, is it a Face-sealed (barrier) EIFS Assembly or a Drainable EIFS Assembly?',
          options: [
            {
              label: 'Face-sealed (barrier) EIFS Assembly',
              value: 'face_sealed',
            },
            { label: 'Drainable EIFS Assembly', value: 'drainable_eifs' },

            { label: 'N/A (No EIFS)', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_it_face_sealed_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'no_of_stories',
          type: 'text',
          label:
            '6. # of stories (if portions of basement are at or above grade, so indicate, for example, "3, plus partially at grade basement")?',
          span: HALF_ROW,
        },
        {
          key: 'no_of_stories_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'finished_basement',
          type: 'radio',
          label: '7. Finished basement?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            { label: 'No', value: 'no' },

            { label: 'U/D', value: 'ud' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'finished_basement_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'year_build',
          type: 'text',
          label: '8. Year built?',

          span: HALF_ROW,
        },
        {
          key: 'year_build_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'year_gut_rehabbed',
          type: 'text',
          label: '9. Year gut-rehabbed, if so (otherwise indicate "N/A")? ',

          span: HALF_ROW,
        },
        {
          key: 'year_gut_rehabbed_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'load_bearing_joists',
          type: 'radio',
          label: '10. Load-bearing joists?',
          options: [
            {
              label: 'Wood',
              value: 'wood',
            },
            { label: 'Steel', value: 'steel' },

            { label: 'Concrete', value: 'concrete' },
            { label: 'U/D', value: 'ud' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'load_bearing_joists_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'roof_structure',
          type: 'checkbox',
          label: '11. Roof structure?',
          options: [
            {
              label: 'Wood joists',
              value: 'wood_joists',
            },
            { label: 'Wood trusses', value: 'wood_trusses' },

            { label: 'Laminated wood beams', value: 'laminated_wood_beams' },
            { label: 'Steel trusses', value: 'steel_trusses' },
            { label: 'Steel purlins', value: 'steel_purlins' },
            { label: 'Concrete', value: 'concrete' },
            { label: 'U/D', value: 'ud' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'roof_structure_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'roof_slope',
          type: 'radio',
          label: '12. Roof slope?',
          options: [
            {
              label: 'Flat',
              value: 'flat',
            },
            { label: 'Pitched', value: 'pitched' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'roof_slope_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'parapet_height',
          type: 'text',
          label: '13. If a flat roof, what is the parapet height, if any? ',
          span: HALF_ROW,
        },
        {
          key: 'parapet_height_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'roof_covering',
          type: 'radio',
          label: '14. Roof covering?',
          options: [
            {
              label: 'Rubber',
              value: 'rubber',
            },
            { label: 'Rolled asphalt', value: 'rolled_asphalt' },
            { label: 'Metal', value: 'metal' },
            { label: 'Other (describe)', value: 'other' },
            { label: 'U/D', value: 'ud' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'roof_covering_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'type_of_wiring',
          type: 'checkbox',
          label: '15. Type of wiring (check all that apply)?',
          options: [
            {
              label: 'Romex',
              value: 'romex',
            },
            { label: 'BX Cable', value: 'bx_cable' },
            { label: 'Conduit', value: 'conduit' },
            { label: 'Knob & Tube', value: 'knob_and_tube' },
            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'type_of_wiring_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'overprotection',
          type: 'radio',
          label: '16. Overprotection?',
          options: [
            {
              label: 'Circuit breakers',
              value: 'circuit_breakers',
            },
            { label: 'Fuses', value: 'fuses' },

            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'overprotection_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'type_of_piping',
          type: 'radio',
          label: '17. Type of piping (check all that apply)?',
          options: [
            {
              label: 'Copper',
              value: 'copper',
            },
            { label: 'Galvanized', value: 'galvanized' },
            { label: 'Iron', value: 'iron' },
            { label: 'PVC', value: 'pvc' },
            { label: 'Brass', value: 'brass' },

            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'type_of_piping_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'heat_type',
          type: 'checkbox',
          label: '18. Heat type?',
          options: [
            {
              label: 'Low Pressure Steam',
              value: 'low_pressure_steam',
            },
            { label: 'Baseboard Hot Water', value: 'baseboard_hot_water' },
            { label: 'Forced Air', value: 'Forced_air' },
            { label: 'Radiant', value: 'radiant' },
            { label: 'HVAC', value: 'hvac' },
            { label: 'Electric', value: 'electric' },
            { label: 'Space Heaters', value: 'space_heaters' },
            { label: 'Woodstove', value: 'woodstove' },
            { label: 'Fireplace', value: 'fireplace' },
            { label: 'Other', value: 'other' },

            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'heat_type_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'floors',
          type: 'checkbox',
          label: '20. Floors?',
          options: [
            {
              label: 'Wood',
              value: 'wood',
            },
            { label: 'Concrete', value: 'concrete' },
            { label: 'Forced Air', value: 'Forced_air' },
            { label: 'Radiant', value: 'radiant' },
            { label: 'Other', value: 'other' },

            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'floors_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'firewalls',
          type: 'radio',
          label: '21. Firewalls?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },

            { label: 'U/D', value: 'ud' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'firewalls_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'firedoors',
          type: 'radio',
          label: '22. Firedoors?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },

            { label: 'U/D', value: 'ud' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'firedoors_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'enclosed_stairwells',
          type: 'radio',
          label: '23. Enclosed stairwells?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },

            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'enclosed_stairwells_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'exterior_stairways',
          type: 'radio',
          label: '24. Exterior stairways?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },

            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'exterior_stairways_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
        {
          key: 'are_stairways_combustible_or_non',
          type: 'radio',
          label: '25. Are stairways combustible or noncombustible? ',
          options: [
            { label: 'Combustible', value: 'combustible' },
            { label: 'Non-combustible', value: 'non_combustible' },

            { label: 'U/D', value: 'ud' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_stairways_combustible_or_non_comment',
          type: 'text',
          label: 'Comment',
          span: HALF_ROW,
        },
      ],
    },
    {
      title:
        'Building Updates (as needed, Duplicate, Label & Complete for EACH bldg)',
      description:
        ' Indicate "O", if ORIGINAL, "L/O", if LARGELY ORIGINAL; otherwise indicate year of, for example, new roof covering ** BE SPECIFIC, e.g., "100% roof covering (rubber) replacement, or, for plumbing upgrades,"All drains in basement and major supply line (copper) risers replaced"',
      components: [
        {
          key: 'roof',
          type: 'text',
          label: '1. Roof',
          span: HALF_ROW,
        },
        {
          key: 'roof_comment',
          type: 'text',
          label: 'Description of Update/Extent of Replacement',
          span: HALF_ROW,
        },
        {
          key: 'electrical',
          type: 'text',
          label: '2. Electrical',
          span: HALF_ROW,
        },
        {
          key: 'electrical_comment',
          type: 'text',
          label: 'Description of Update/Extent of Replacement',
          span: HALF_ROW,
        },
        {
          key: 'plumbing',
          type: 'text',
          label: '3. Plumbing',
          span: HALF_ROW,
        },
        {
          key: 'plumbing_comment',
          type: 'text',
          label: 'Description of Update/Extent of Replacement',
          span: HALF_ROW,
        },
        {
          key: 'heating',
          type: 'text',
          label: '4. Heating',
          span: HALF_ROW,
        },
        {
          key: 'heating_comment',
          type: 'text',
          label: 'Description of Update/Extent of Replacement',
          span: HALF_ROW,
        },
        {
          key: 'ac_system',
          type: 'text',
          label: '5. A/C system',
          span: HALF_ROW,
        },
        {
          key: 'ac_system_comment',
          type: 'text',
          label: 'Description of Update/Extent of Replacement',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Property Hazards',
      description:
        'Calls for additional data/descriptions and all "No" responses require a "Comment"',
      components: [
        {
          key: 'risk_secured_from_unauthorized_access',
          type: 'radio',
          label: '1. Risk secured from unauthorized access?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          comment: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_secured_from_unauthorized_access_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_with_entry_system',
          type: 'radio',
          label: '2. Risk with key/buzzer/intercom entry system? ',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_with_entry_system_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_have_central_station_burglar_alarm_system',
          type: 'radio',
          label: '3. Does risk have a central station burglar alarm system?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_have_central_station_burglar_alarm_system_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'name_of_central_station_monitoring_company',
          type: 'text',
          label: '4. Name of the central station monitoring company?',

          span: HALF_ROW,
        },
        {
          key: 'name_of_central_station_monitoring_company_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'monitored_surveillance_cameras',
          type: 'radio',
          label:
            '5. Monitored surveillance cameras (if Yes, covering what areas & how monitored)?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'monitored_surveillance_cameras_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'are_grade_level_window_and_door_opening_secured',
          type: 'radio',
          label:
            '6. If a building is vacant, are grade level window and door openings secured?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_grade_level_window_and_door_opening_secured_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'was_roof_accessed',
          type: 'radio',
          label:
            '7. If flat, was roof accessed (if Yes, provide a PHOTO confirming same; if No, EXPLAIN WHY no roof access)?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'was_roof_accessed_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'roof_free_of_evidenced_damage',
          type: 'radio',
          label:
            '8. Roof free of any evidenced damage, deterioration or leaks (if No, indicate how determined and provide supportive photos)?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            {
              label: 'U/D (no roof access &/or not otherwise determinable))',
              value: 'ud',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'roof_free_of_evidenced_damage_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'parapets_chimneys_in_good_condition',
          type: 'radio',
          label:
            '9. Parapets, chimneys, gutters & downspouts all in good condition?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            {
              label: 'U/D (no roof access &/or not otherwise determinable)',
              value: 'ud',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'parapets_chimneys_in_good_condition_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'type_of_rook_door_locking_mechanism',
          type: 'checkbox',
          label:
            '10. Type of roof door/hatch locking mechanism (& provide a PHOTO)?',

          options: [
            {
              label: 'Panic hardware with intrusion alarm',
              value: 'panic_hardware_with_intrusion_alarm',
            },
            { label: 'Panic hardware', value: 'panic_hardware' },
            {
              label: 'Slide bolt',
              value: 'slide_bolt',
            },
            {
              label: 'Other (describe) ',
              value: 'other',
            },
            {
              label: 'None',
              value: 'none',
            },
            {
              label: 'N/A',
              value: 'nas',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'type_of_rook_door_locking_mechanism_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'if_not_directly_connected_to_the_roof_door_locking_mechanism_does_the_bulkhead_stairway_area_have_a_motion_detector_activated_audible_intrusion_alarm',
          type: 'radio',
          label:
            '11. If not directly connected to the roof door locking mechanism, does the bulkhead stairway area have a motion detector-activated audible intrusion alarm ?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            {
              label: 'U/D (no roof access &/or not otherwise determinable)',
              value: 'ud',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'if_not_directly_connected_to_the_roof_door_locking_mechanism_does_the_bulkhead_stairway_area_have_a_motion_detector_activated_audible_intrusion_alarm_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'flat_roof_free_of_unauthorized_tenant_activity_or_designed_for_tenant_use',
          type: 'radio',
          label:
            '12. If a flat roof, is it free of evidenced casual, unauthorized tenant activity (also check Yes, if the rooftop has been designed for tenant use, as is the case, for example, with some penthouse dwellings)?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            {
              label: 'U/D (no roof access &/or not otherwise determinable)',
              value: 'ud',
            },
            {
              label: 'N/A',
              value: 'na',
            },
            {
              label: 'U/D (no roof access)',
              value: 'ud',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'flat_roof_free_of_unauthorized_tenant_activity_or_designed_for_tenant_use_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'are_tenants_prohibited_from_owning_bbq_grills',
          type: 'radio',
          label: '13. Are tenants prohibited from owning bbq grills?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_tenants_prohibited_from_owning_bbq_grills_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_propane_grills_and_bbq_units_near_building',
          type: 'radio',
          label:
            '14. Risk free of propane grills and other BBQ units on rooftops, balconys, porches or within 10 feet of the building?',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            { label: 'U/D (no roof of access)', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_propane_grills_and_bbq_units_near_building_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'housekeeping_satisfactory_and_free_of_refuse_debris',
          type: 'radio',
          label:
            '15. Housekeeping satisfactory and with premises free of accumulated refuse & debris? ',

          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'housekeeping_satisfactory_and_free_of_refuse_debris_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'EIFS_stucco_free_of_deficiencies',
          type: 'radio',
          label:
            '16. If EIFS stucco clad, is the application free of any indicated/observed deficiencies?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'EIFS_stucco_free_of_deficiencies_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'ceilings_good_condition_free_of_damage',
          type: 'radio',
          label:
            '17. Ceilings in good condition, free of water stains and other damage?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'ceilings_good_condition_free_of_damage_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'flooe_in_good_condition',
          type: 'radio',
          label: '18. Floors in good condition?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'flooe_in_good_condition_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'wiring_electrical_system_safe_and_free_of_deficiencies',
          type: 'radio',
          label:
            '19. Does the wiring & electrical system, including junction & panel boxes, etc., all appear safely arranged and free of observed deficiencies (if No, FULLY DESCRIBE & LOCATE)?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'wiring_electrical_system_safe_and_free_of_deficiencies_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'have_electrical_panles_ever_had_infrared',
          type: 'radio',
          label:
            '20. Have the electrical panels ever had Infrared Scanning performed (if Yes, on what cadence)?',
          options: [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'have_electrical_panles_ever_had_infrared_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_observed_or_reported_aluminum_wiring_1965_1975',
          type: 'radio',
          label:
            '21. If built during during the years 1965-1975 and of residential construction (OTHERWISE, CHECK "N/A"), is risk free of any observed or reported branch aluminum ("AL") wiring (BE SURE TO ASK, even if none is observed)?',
          options: [
            {
              label:
                'Yes- no observed branch AL wiring (describe how determined)',
              value: 'no_observed_aluminum_wiring',
            },
            {
              label:
                'Yes- no verbally reported branch AL wiring (indicate by whom & position)',
              value: 'no_reported_aluminum_wiring',
            },
            {
              label:
                'No, risk does have branch AL wiring (FULLY describe, incl. how determined & where)',
              value: 'risk_has_aluminum_wiring_described',
            },
            { label: 'U/D', value: 'ud' },
            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_observed_or_reported_aluminum_wiring_1965_1975_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'branch_aluminum_wiring_upgraded_or_updated',
          type: 'checkbox',
          label:
            '22. If "No" to the above (OTHERWISE, CHECK "N/A"), has the branch aluminum wiring been upgraded, either by pigtailing, using special COALUM connectors or by replacing the original switches and receptacles with approved "CO/ALR" switches and receptacles (even if none is observed BE SURE TO ASK if the branch aluminum wiring has been pigtailed or otherwise updated)?',
          options: [
            {
              label:
                'Yes - observed to be upgraded (detail, incl. how & where & provide photo)',
              value: 'aluminum_wiring_observed_upgraded',
            },
            {
              label: 'Yes-upgraded, with documentation provided',
              value: 'aluminum_wiring_upgraded_with_docs',
            },
            {
              label: 'Yes-verbally, w/o documentation',
              value: 'aluminum_wiring_upgraded_verbally',
            },
            { label: 'No-not upgraded', value: 'aluminum_wiring_not_upgraded' },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'branch_aluminum_wiring_upgraded_or_updated_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_FPE_stab_lok_panels_breakers',
          type: 'radio',
          label:
            '23. Is risk free of Federal Pacific Electric (FPE) Stab-Lok type electrical panels & circuit breakersMOVE CURSOR OVER TEXT FOR DETAILS (if No, provide a CLOSE-UP PHOTO SHOWING "STAB-LOK" ON THE LABEL?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_FPE_stab_lok_panels_breakers_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_sylvania_zinsco_breakers',
          type: 'radio',
          label:
            '24. Is risk free of GTE Sylvania Zinsco circuit breakers- MOVE CURSOR OVER TEXT FOR DETAILS (if No, provide a CLOSE-UP PHOTO SHOWING "Sylvania Zinsco" label)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_sylvania_zinsco_breakers_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_observed_extention_cord_overuse',
          type: 'radio',
          label: '25. Is risk free of observed extension cord overuse?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_observed_extention_cord_overuse_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'plumbing_adequate_maintained_free_of_deficiencies',
          type: 'radio',
          label:
            '26. Does the plumbing, including all observed piping, appear adequate and satisfactorily maintained, while free of leaks, seepage, rust, damage or other deficiencies (if No, FULLY describe & locate)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'plumbing_adequate_maintained_free_of_deficiencies_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'are_space_heaters_prohibited_inside_units',
          type: 'radio',
          label: '27. Are space heaters prohibited inside units?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_space_heaters_prohibited_inside_units_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'if_building_vacant',
          type: 'radio',
          label:
            '28. If building is vacant, what utilities, if any, remain on (check all that apply)?',
          options: [
            {
              label: 'Electric',
              value: 'electric',
            },
            {
              label: 'Heat',
              value: 'heat',
            },
            {
              label: 'Water',
              value: 'water',
            },
            {
              label: 'None',
              value: 'none',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'if_building_vacant_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'unheated_areas_drained_or_antifreeze_added',
          type: 'radio',
          label:
            '29. If vacant & unheated (or only partially heated), have all unheated areas with piping been drained of water so as to prevent freezing/bursting of piping during cold weather months (If No, has an approved antifreeze mix been added to the water)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'unheated_areas_drained_or_antifreeze_added_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_mold_or_contributing_conditions',
          type: 'radio',
          label:
            '30. Is risk free of evidenced mold or conditions contributing to same (if No, detail, including likely source)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },

            { label: 'N/A', value: 'na' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_mold_or_contributing_conditions_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'are_there_washer_in_the_building',
          type: 'radio',
          label: '31. Are there washer/dryers in the buildings?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_there_washer_in_the_building_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'are_dryer_ducts_cleaned_at_least_annually',
          type: 'radio',
          label: '32. Are dryer ducts cleaned at least annually?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_dryer_ducts_cleaned_at_least_annually_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'on_site_washer_inspected_annually_for_clogged_dryer_vents',
          type: 'radio',
          label:
            '33. Are on-site washers/dryers inspected at least annually for clogged dryer vents?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'on_site_washer_inspected_annually_for_clogged_dryer_vents_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'on_site_washer_inspected_annually_for_leaking_hoses',
          type: 'radio',
          label:
            '34. Are on-site washers/dryers inspected at least annually for leaking hoses?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'on_site_washer_inspected_annually_for_leaking_hoses_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'dryer_free_of_observed_lint_build_up',
          type: 'radio',
          label: '35. Are dryers free of observed lint build-up?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'dryer_free_of_observed_lint_build_up_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'any_fire_code_violations_in_last_five_years',
          type: 'checkbox',
          label:
            '36. Have there been any fire code violations in the last 5 years (if Yes, please elaborate)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'any_fire_code_violations_in_last_five_years_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Private Protection (duplicate & label as needed)',
      description:
        'Calls for data/descriptions and most "No" responses require a "Comment"',
      components: [
        {
          key: 'sprinkler_systems_fire_pumps_tested_maintained',
          type: 'radio',
          label:
            '1. If applicable, are sprinkler sprinkler systems/fire pumps routinely tested/maintained (if there is a sprinkler system, please complete the Sprinkler Section below)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_systems_fire_pumps_tested_maintained_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'does_risk_have_pulldown_fire_alarm_system',
          type: 'radio',
          label:
            '2. Does risk have pulldown fire alarm system, with pull stations by all exit doors?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'does_risk_have_pulldown_fire_alarm_system_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'is_there_fire_extinguisher_in_every_building',
          type: 'radio',
          label: '3. Is there a fire extinguisher in at least every building?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_there_fire_extinguisher_in_every_building_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'fire_extinguishers_properly_mounted',
          type: 'radio',
          label:
            '4. Are fire extinguishers of correct type and # & properly mounted, where prescribed (if No, describe)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'fire_extinguishers_properly_mounted_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'fire_extinguishers_with_recent_inspection_tags',
          type: 'radio',
          label:
            '5. Do all fire extinguishers have a durable inspection tag affixed and showing a dated inspection within the past twelve months by a company certified to service portable fire extinguishers?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'fire_extinguishers_with_recent_inspection_tags_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'smoke_detectors',
          type: 'checkbox',
          label: '6. Smoke detectors (check type)?',
          options: [
            {
              label: 'Hard-wired with battery back-up',
              value: 'hard_wired_with_battery_backup',
            },
            {
              label: 'Hard-wired',
              value: 'hard_wired',
            },
            {
              label: 'Battery',
              value: 'battery',
            },
            {
              label: 'None',
              value: 'none',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'smoke_detectors_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_have_documented_schedule_for_replacement',
          type: 'radio',
          label:
            '7. Does risk have a documented schedule for the replacement of smoke detector batteries?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_have_documented_schedule_for_replacement_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_have_central_station_fire_alarm_system',
          type: 'radio',
          label: '8. Does risk have a central station fire alarm system?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_have_central_station_fire_alarm_system_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
      ],
    },
    {
      title:
        'Sprinkler Protection (omit if no sprinkler system, duplicate as needed)',
      components: [
        {
          key: 'premises_hundered_sprinklered_with_confirmatory_photos',
          type: 'radio',
          label:
            '1. Is risk premises 100% sprinklered (if only partially sprinklered, indicate which areas are sprinkler-protected.) IN ALL CASES, PROVIDE CONFIRMATORY FLOOR-TO-CEILING PHOTOS SHOWING AT LEAST ONE SPRINKLER HEAD IN EACH OF THE COVERAGE AREAS E.G. FOR AN APARTMENT BUILDING, A COMMON HALLWAY CORRIDOR, AN APARTMENT UNIT & A LAUNDRY ROOM.',
          options: [
            {
              label: '100% sprinklered ',
              value: '100_percent_sprinklered',
            },
            {
              label: 'Partially sprinklered (indicate where)',
              value: 'partially',
            },
            {
              label: 'Not sprinkler-protected',
              value: 'not_sprinkler_protected',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'premises_hundered_sprinklered_with_confirmatory_photos_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_system_type',
          type: 'radio',
          label:
            '2. If sprinklered, type of system (e.g. Wet, Dry, Deluge, Hirack, ESFR)?',
          options: [
            {
              label: 'Wet',
              value: 'wet',
            },
            {
              label: 'Dry',
              value: 'dry',
            },
            {
              label: 'Other (describe)',
              value: 'other',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_system_type_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'vacant_water_on_for_sprinkler_system',
          type: 'radio',
          label:
            '3. If vacant, is the water still on, so as to provide continuous water supply to the sprinkler piping/system?',
          options: [
            {
              label: 'Wet',
              value: 'wet',
            },
            {
              label: 'Dry',
              value: 'dry',
            },
            {
              label: 'Other (describe)',
              value: 'other',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'vacant_water_on_for_sprinkler_system_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'wet_sprinkler_areas_heated_min_55_degrees',
          type: 'radio',
          label:
            '4. Are all wet sprinkler-protected areas heated to a minimum of 55 degrees, so as to prevent bursting of piping during cold weather months?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'wet_sprinkler_areas_heated_min_55_degrees_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_system_appear_in_working_order',
          type: 'radio',
          label: '5. Does sprinkler system appear in good working order?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_system_appear_in_working_order_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_heads_over_50_replaced_or_tested',
          type: 'radio',
          label:
            '6. Are all sprinkler heads over 50 years old replaced or sample tested (at 10 year intervals)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_heads_over_50_replaced_or_tested_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_main_valve_locked_open_with_extra_heads_wrench',
          type: 'radio',
          label:
            '7. Is sprinkler main valve locked in open position (PROVIDE PHOTO) and with extra sprinkler heads & wrench by same?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_main_valve_locked_open_with_extra_heads_wrench_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_system_inspected_within_12_months',
          type: 'radio',
          label:
            '8. Sprinkler system with contracted inspection within last twelve months?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'sprinkler_system_inspected_within_12_months_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Public Protection',
      description:
        'Paid, Part-paid,Volunteer ** If known (e.g. NYC is class 4) ***Public or Private (if undetermined, state "U/D")',
      components: [
        {
          key: 'dept_nane',
          type: 'text',
          label: 'Dept. Name',

          span: HALF_ROW,
        },
        {
          key: 'type',
          type: 'text',
          label: 'Type',

          span: HALF_ROW,
        },
        {
          key: 'iso_class',
          type: 'text',
          label: 'ISO Class',

          span: HALF_ROW,
        },
        {
          key: 'how_far_away',
          type: 'text',
          label: 'How far away',

          span: HALF_ROW,
        },
        {
          key: 'water_supply',
          type: 'text',
          label: 'Water Supply',

          span: HALF_ROW,
        },
        {
          key: 'dist_to_gydrant',
          type: 'text',
          label: 'Dist. to hydrant',

          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Exposures',
      description: 'Calls for additional data/description requires a "Comment"',
      components: [
        {
          key: 'distance_between_risk_and_non_risk',
          type: 'text',
          label:
            '1. Distance (in feet) between risk and non-risk exposure buildings within 100 feet of risk',
          span: HALF_ROW,
        },
        {
          key: 'distance_between_risk_and_non_risk_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'multi_building_risk_from_each_other',
          type: 'radio',
          label:
            '2. If a multi-building risk (e.g. an apartment complex), are buildings minimally 50" from each other (if No, what is the actual distance between buildings)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'multi_building_risk_from_each_other_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_hazardous_occupancies',
          type: 'radio',
          label:
            '3. Is risk free of hazardous occupancies within 100" of risk (if No, FULLY describe)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'risk_free_of_hazardous_occupancies_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },

        {
          key: 'are_adjacent_properties_undergoing',
          type: 'radio',
          label:
            '4. Are adjacent properties undergoing any construction/excavation/demolition activities (if Yes, describe and PROVIDE A PHOTO)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_adjacent_properties_undergoing_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'are_trees_near_building_trimmed_back_at_least_annually',
          type: 'radio',
          label: '5. Are trees near buildings trimmed back at least annually?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
            {
              label: 'N/A',
              value: 'na',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'are_trees_near_building_trimmed_back_at_least_annually_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'is_risk_free_of_any_overhanging',
          type: 'radio',
          label:
            '6. Is risk free of any overhanging tree limbs and/or large dead or dying trees within 100" (if No, describe)? ',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_risk_free_of_any_overhanging_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'any_history_of_heavy_snow',
          type: 'radio',
          label:
            '7. Any history of heavy snow build-up on roof (if Yes, detail, including frequency and whether collapse ever ensued)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'any_history_of_heavy_snow_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'distance_to_nearest_brush',
          type: 'text',
          label:
            '8. Distance (in feet) to nearest brush and/or woods exposure?',

          span: HALF_ROW,
        },
        {
          key: 'distance_to_nearest_brush_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'any_history_of_brush_and_wild_fire_in_general_area',
          type: 'radio',
          label:
            '9. Any history of brush and/or wild fires in the general area (if Yes, detail, including frequency, proximity and whether evacuation was ever ordered)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'any_history_of_brush_and_wild_fire_in_general_area_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'is_risk_in_water_bodies',
          type: 'radio',
          label:
            '10. Is risk within 3,000 feet of bodies of water, including oceans, Intercoastal waterways, rivers, and creeks that have a history of flooding (if Yes, FULLY describe, including the actual distance to the water source, whether risk is located in a designated flood plain, and if the area has a history of flooding and/or storm surge)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_risk_in_water_bodies_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'any_history_of_landslides_or_stinkholes_in_general_area',
          type: 'radio',
          label:
            '11. Any history of landslides or sinkholes in the general area (if Yes, detail, including frequency, proximity and whether evacuation was ever ordered)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'any_history_of_landslides_or_stinkholes_in_general_area_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'type_of_neighborhood',
          type: 'checkbox',
          label: '12. Type of neighborhood (check all that apply)?',
          options: [
            {
              label: 'Residential',
              value: 'residential',
            },
            {
              label: 'Commercial',
              value: 'commercial',
            },
            {
              label: 'Industrial',
              value: 'industrial',
            },
            {
              label: 'Urban',
              value: 'urban',
            },
            {
              label: 'Suburban',
              value: 'suburban',
            },
            {
              label: 'Rural',
              value: 'rural',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'type_of_neighborhood_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
        {
          key: 'neighborhood_stable_and_free_of_evidenced_vanadalism',
          type: 'radio',
          label:
            '13. Is neighborhood stable and free of evidenced vandalism, mischief activity, gang activity, vacant buildings, etc. (if No, FULLY explain)?',
          options: [
            {
              label: 'Yes',
              value: 'yes',
            },
            {
              label: 'No',
              value: 'no',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'neighborhood_stable_and_free_of_evidenced_vanadalism_comment',
          type: 'text',
          label: 'Comments',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Opinion of Risk',
      components: [
        {
          key: 'opinion_of_risk',
          label: 'Opinion of Risk',
          type: 'radio',
          options: [
            { label: 'Excellent', value: 'excellent' },
            { label: 'Good', value: 'good' },
            {
              label:
                'Good, but with Property or Liability recommendations noted',
              value: 'recommendations_noted',
            },
            { label: 'Poor', value: 'poor' },
          ],
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Disclaimer',
      components: [
        {
          key: 'disclaimer',
          type: 'note',
          label:
            'It cannot be expected or presumed that all unsafe conditions or procedures will be discovered by our survey. We make no representation nor do we warrant that buildings, premises, locations, operations, machinery, equipment, vehicles, procedures, workplaces or products are completely safe, healthful, and/or are in compliance with every law, regulation or rule that might apply. Additionally, we offer no verification as to the authenticity and/or completeness of statements made by insureds or their representatives and incorporated into our surveys. Furthermore, we are not appraisers and do not offer our opinions with respect to insurance to value. The purpose of an insurance loss control survey is to check for the existence of hazards and not to determine valuation. Also, while we strive to maintain consistent timeliness, we make no warranty that reports will be received within a certain period of time, as many factors that adversely affect time service are beyond our control.',
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'General Data Heading',
      components: [
        {
          key: 'account',
          type: 'text',
          label: 'Account:',
          span: HALF_ROW,
        },
        {
          key: 'order_type',
          type: 'text',
          label: 'Order type:',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Recommendations',
      components: [
        {
          key: 'inspection_recommendations',
          type: 'textarea',
          label: 'Inspection Recommendations',
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'General Information',
      components: [
        {
          key: 'firm_name',
          type: 'text',
          label: 'Firm Name',
          required: true,
          span: HALF_ROW,
        },
        {
          key: 'underwriter',
          type: 'text',
          label: 'Underwriter',
          required: true,
          span: HALF_ROW,
        },
        {
          key: 'uw_phone',
          type: 'text',
          label: 'UW Phone (optional)',
          span: HALF_ROW,
        },
        {
          key: 'uw_email',
          type: 'text',
          label: 'UW Email',
          required: true,
          span: HALF_ROW,
        },
        {
          key: 'broker_contact',
          type: 'text',
          label: 'Broker Contact',
          span: HALF_ROW,
        },
        {
          key: 'broker_telephone',
          type: 'text',
          label: 'Broker Telephone',
          span: HALF_ROW,
        },
        {
          key: 'broker_email',
          type: 'text',
          label: 'Broker Email (optional)',
          span: HALF_ROW,
        },
        {
          key: 'retail_broker_agency',
          type: 'text',
          label: 'Retail Broker/Agency',
          span: HALF_ROW,
        },
        {
          key: 'retail_broker_telephone',
          type: 'text',
          label: 'Retail Broker Telephone',
          span: HALF_ROW,
        },
        {
          key: 'request_is',
          type: 'checkbox',
          label: 'Request is:',
          options: [
            { label: 'New', value: 'New' },
            { label: 'Renewal', value: 'Renewal' },
            { label: 'Recommendation Check', value: 'Recommendation Check' },
            { label: 'Telephone survey only', value: 'Telephone survey only' },
            { label: 'Virtual survey', value: 'Virtual survey' },
            { label: 'Sidewalk Only Survey', value: 'Sidewalk Only Survey' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'rush_order',
          type: 'checkbox',
          label: 'Rush Order',
          span: HALF_ROW,
          options: [{ label: 'Rush Order', value: 'Yes' }],
        },
        {
          key: 'due_date',
          type: 'radio',
          label: 'Due Date:',
          options: [
            { label: '30 Days', value: '30 Days' },
            { label: '21 Days', value: '21 Days' },
            {
              label: '7-10 Days (ONLY on Rush Orders-see above)',
              value: '7-10 Days (ONLY on Rush Orders-see above)',
            },
          ],
          span: HALF_ROW,
        },
        {
          key: 'delayed_due_date',
          type: 'text',
          label: 'Delayed Due Date (enter the requested service date range)',

          span: HALF_ROW,
        },
        {
          key: 'eff_date',
          type: 'text',
          label: 'EFF. date (optional)',

          span: HALF_ROW,
        },

        {
          key: 'photos_required',
          type: 'radio',
          label: 'Photos (interior/exterior/hazards) required',
          options: [
            { label: 'Yes', value: 'Yes' },
            { label: 'No', value: 'No' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'is_itv_required',
          type: 'radio',
          label: 'Is an ITV Required?',
          options: [
            { label: 'Yes', value: 'Yes' },
            { label: 'No', value: 'No' },
          ],
          span: HALF_ROW,
        },
        {
          key: 'diagram_required',
          type: 'dropdown',
          label:
            'Diagram (or plot plan) required (and to include risk dimensions and approx. distances to exposure buildings):',
          options: [
            { label: 'Select', value: '' },
            { label: 'Yes', value: 'Yes' },
            { label: 'No', value: 'No' },
          ],
          span: FULL_ROW,
        },
        {
          key: 'list_addresses_to_be_surveyed_with_main_location_above',
          type: 'textarea',
          label:
            'Additional Addresses (to be surveyed in ONE report, for the main location/address noted above):',

          span: HALF_ROW,
        },
        {
          key: 'inspection_contact',
          type: 'text',
          label: 'Inspection Contact',

          span: FULL_ROW,
        },
        {
          key: 'contact_telephone',
          type: 'text',
          label: 'Contact Telephone',

          span: FULL_ROW,
        },
        {
          key: 'contact_mobile',
          type: 'text',
          label: 'Contact Mobile',

          span: HALF_ROW,
        },
        {
          key: 'contact_email',
          type: 'text',
          label: 'Contact e-mail (optional)',

          span: HALF_ROW,
        },
        {
          key: 'alternate_inspection_contact_info',
          type: 'textarea',
          label: 'Alternate Inspection Contact Info',

          span: FULL_ROW,
        },
        {
          key: 'nature_of_business',
          type: 'textarea',
          label: 'Nature of Business/Operations',
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Climatic Perils Supplements',
      components: [
        {
          key: 'climatic_perils_supplements',
          type: 'checkbox',
          label:
            'Required Survey Form (check only if required as additional to standard forms):',
          options: [
            { label: 'Wildfire Supplement', value: 'Wildfire Supplement' },
            {
              label: 'Earthquake and Flood Supplement',
              value: 'Earthquake and Flood Supplement',
            },
          ],
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Policy Type',
      components: [
        {
          key: 'coverage',
          type: 'checkbox',
          label: 'Coverage(s)',
          options: [
            { label: 'BOP', value: 'BOP' },
            { label: 'Package', value: 'Package' },
            { label: 'Monoline GL', value: 'Monoline GL' },
            { label: 'Monoline Property', value: 'Monoline Property' },
            {
              label: 'Dwelling - Exterior Only',
              value: 'Dwelling - Exterior Only',
            },
            { label: 'Garage', value: 'Garage' },
            { label: 'Auto Physical Damage', value: 'Auto Physical Damage' },
            { label: 'Workers Comp', value: 'Workers Comp' },
            { label: 'Sidewalk Only', value: 'Sidewalk Only' },
            { label: 'Rec Check', value: 'Rec Check' },
          ],
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Liability',
      components: [
        {
          key: 'liabilities',
          type: 'checkbox',
          label: 'Indicate all that apply',
          options: [
            {
              label: 'Commercial General Liability',
              value: 'Commercial General Liability',
            },
            { label: 'Auto Liability', value: 'Auto Liability' },
            {
              label: 'Professional Liability',
              value: 'Professional Liability',
            },
            { label: 'Products Liability', value: 'Products Liability' },
            { label: 'Liquor Liability', value: 'Liquor Liability' },
            { label: 'Garage/GKLL', value: 'Garage/GKLL' },
            { label: 'OCP', value: 'OCP' },
          ],
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Crime',
      components: [
        {
          key: 'employee_dishonesty_amount',
          type: 'text',
          label: 'Employee Dishonesty $',
          span: HALF_ROW,
        },
        {
          key: 'robbery_mon_sec_amount',
          type: 'text',
          label: 'Robbery Mon. & Sec. $',
          span: HALF_ROW,
        },
        {
          key: 'burglary_amount',
          type: 'text',
          label: 'Burglary $',
          span: HALF_ROW,
        },
        {
          key: 'theft_amount',
          type: 'text',
          label: 'Theft $',
          span: HALF_ROW,
        },
      ],
    },
    {
      title: 'Inland/Ocean Marine',
      components: [
        {
          key: 'inland_ocean_marine_description',
          type: 'textarea',
          label:
            "Describe Coverage (e.g. Bailee, Cargo, Jeweler's Block, Transit, etc., along with goods, cargo and/or equipment covered, and their dollar values)",
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Additional Instructions/Special Coverages',
      components: [
        {
          key: 'additional_instructions',
          type: 'textarea',
          label: 'Please List or Describe',
          span: FULL_ROW,
        },
        {
          key: 'earlier_recommendations',
          type: 'textarea',
          label: 'Earlier Recommendations (to be checked for compliance)',
          span: FULL_ROW,
        },
      ],
    },
    {
      title: 'Disclaimer',
      components: [
        {
          key: 'disclaimer',
          type: 'note',
          label:
            'This order form is for the purpose of ordering an insurance loss control survey of hazards; it is not a request for an insurance to value report. Please contact TIS (800-557-1147) for property valuation requests.',
          span: FULL_ROW,
        },
      ],
    },
  ],
};
