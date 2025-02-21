# frozen_string_literal: true

desc 'Migrate Data from Assessment Action Results to Associated Activities and Associated Triggers'
task data_migration_to_associated_activities: :environment do
  ActiveRecord::Base.transaction do
    Assessment::ActionResult.find_each do |assessment_action_result|
      activity_action = assessment_action_result.activity_action
      next if activity_action.blank?

      activity = activity_action.activity
      next if activity.blank?

      assessment = assessment_action_result.assessment
      next if assessment.blank?

      puts "Creating associated activity for assessment ID: #{assessment.id} and activity ID: #{activity.id}"
      associated_activity = assessment.associated_activities.find_or_initialize_by(activity_id: activity.id)
      associated_activity.skip_associated_activity_actions_creation = true if associated_activity.new_record?
      associated_activity.save!

      puts "Updating associated activity ID for assessment action result ID: #{assessment_action_result.id}"
      assessment_action_result.associated_activity_id = associated_activity.id
      assessment_action_result.save!

      puts 'Updating associated activity ID for assessment action result triggers ' \
           "for assessment action result ID: #{assessment_action_result.id}"
      assessment_action_result.assessment_action_result_triggers.each do |assessment_action_result_trigger|
        next if assessment_action_result_trigger.associated_activity_id.present?

        assessment_action_result_trigger.update!(associated_activity_id: associated_activity.id)
      end
    end
  end

  puts 'Data migration completed'
end
