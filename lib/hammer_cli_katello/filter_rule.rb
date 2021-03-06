module HammerCLIKatello
  class FilterRule < HammerCLIKatello::Command
    resource :content_view_filter_rules
    command_name 'rule'
    desc 'View and manage filter rules'

    class ListCommand < HammerCLIKatello::ListCommand
      include OrganizationOptions

      output do
        field :id, _("Rule ID")
        field :content_view_filter_id, _("Filter ID")

        field :name, _("Name")
        field :version, _("Version")
        field :min_version, _("Minimum Version")
        field :max_version, _("Maximum Version")
        field :architecture, _("Architecture")
        field :errata_id, _("Errata ID")
        field :start_date, _("Start Date")
        field :end_date, _("End Date")
      end

      build_options
    end

    class InfoCommand < HammerCLIKatello::InfoCommand
      include OrganizationOptions

      output do
        field :id, _("Rule ID")
        field :content_view_filter_id, _("Filter ID")

        field :name, _("Name"), Fields::Field, :hide_blank => true
        field :version, _("Version"), Fields::Field, :hide_blank => true
        field :min_version, _("Minimum Version"), Fields::Field, :hide_blank => true
        field :max_version, _("Maximum Version"), Fields::Field, :hide_blank => true
        field :architecture, _("Architecture"), Fields::Field, :hide_blank => true
        field :errata_id, _("Errata ID"), Fields::Field, :hide_blank => true
        field :start_date, _("Start Date"), Fields::Field, :hide_blank => true
        field :end_date, _("End Date"), Fields::Field, :hide_blank => true
        field :date_type, _("Date Type"), Fields::Field, :hide_blank => true
        field :types, _("Types"), Fields::List, :hide_blank => true
        field :created_at, _("Created"), Fields::Date
        field :updated_at, _("Updated"), Fields::Date
      end

      build_options
    end

    class CreateCommand < HammerCLIKatello::CreateCommand
      include OrganizationOptions

      success_message _("Filter rule created.")
      failure_message _("Could not create the filter rule")

      option '--names', 'NAMES', _('Package and package group names')

      def options
        super['option_name'] ||= super['option_names'].split(',') if super['option_names']
        super
      end

      build_options do |o|
        o.expand.except(:module_streams)
        o.without(:module_streams)
      end
    end

    class UpdateCommand < HammerCLIKatello::UpdateCommand
      include OrganizationOptions

      success_message _("Filter rule updated.")
      failure_message _("Could not update the filter rule")

      build_options
    end

    class DeleteCommand < HammerCLIKatello::DeleteCommand
      include OrganizationOptions

      success_message _("Filter rule deleted.")
      failure_message _("Could not delete the filter rule")

      build_options
    end

    autoload_subcommands
  end
end
