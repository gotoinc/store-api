# frozen_string_literal: true

module Documents
  class CloningService

    attr_reader :user, :project

    def initialize(user:, project: nil)
      @user = user
      @project = project
    end

    def call
      DocumentTemplate.all.each do |document_template|
        project.documents.find_or_initialize_by(name: document_template.name) do |document|
          document.document_template = document_template
        end
      end

      user.active_project = active_project
      project.save!
    end

    private

    def active_project
      user.active_project.update(active: false) if project.active? && user.active_project.present?
      project.name = "Valuation #{user.projects.count.next}"

      project
    end
  end
end
