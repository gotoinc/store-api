# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Provider project API' do
  path '/api/v1/provider/categories' do
    let!(:user) {
      stub_jwt_verification(controller: Api::V1::Provider::CategoriesController, payload: { role: :provider })
    }

    get 'List of available categories' do
      tags '#index'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'Provider able to see list of categories' do
        let(:Authorization) { 'Bearer JWT' }

        run_test! do |response|
          data = JSON.parse(response.body).fetch('data', [])

          expect(data.size).to eq(Category.all.count)
        end
      end
    end

    # post 'Create a new project' do
    #   tags '#create'
    #   consumes 'application/json'
    #   security [Bearer: {}]
    #   parameter name: :project_params, in: :body, schema: {
    #     type: :object,
    #     properties: {
    #       status: {
    #         type: :string,
    #         default: :vacant
    #       }
    #     }
    #   }
    #
    #   response '200', 'Customer able to create a new valuation' do
    #     let(:Authorization) { 'Bearer JWT' }
    #     let(:user) {
    #       stub_jwt_verification(
    #         controller: Api::V1::Customer::ProjectsController,
    #         payload: { role: :customer, status: :inactive }
    #       )
    #     }
    #     let(:project_params) { { status: :vacant } }
    #     before do
    #       user.active_project.update(active: false)
    #     end
    #
    #     run_test! do |response|
    #       data = JSON.parse(response.body).fetch('data', [])
    #
    #       expect(response.status).to eq(200)
    #       expect(data['id'].to_i).to eq(user.reload.active_project.id)
    #     end
    #   end
    # end
  end

  # path '/api/v1/customer/projects/{id}' do
  #   parameter name: :id, in: :path, type: :string
  #
  #   let(:id) { project.uuid }
  #   let(:user) {
  #     stub_jwt_verification(controller: Api::V1::Customer::ProjectsController, payload: { role: :customer })
  #   }
  #   let(:project) { create(:project, user_id: user.id, active: true, status: :pending) }
  #
  #   get 'Active project' do
  #     tags '#show'
  #     consumes 'application/json'
  #     security [Bearer: {}]
  #
  #     response '200', 'Able to see active project' do
  #       let(:Authorization) { 'Bearer JWT' }
  #
  #       run_test! do |response|
  #         expect(response.status).to eq(200)
  #       end
  #     end
  #   end
  #
  #   put 'Update an active project' do
  #     tags '#update'
  #     consumes 'application/json'
  #     security [Bearer: {}]
  #
  #     parameter name: :project_params, in: :body, schema: {
  #       type: :object,
  #       properties: {
  #         status: { type: :string },
  #         analyst_id: { type: :string }
  #       }
  #     }
  #
  #     response '200', 'Customer able to update own active project' do
  #       let(:Authorization) { 'Bearer JWT' }
  #       let(:project_params) { { status: :pending } }
  #
  #       run_test! do |response|
  #         data = JSON.parse(response.body)
  #         project_data = data.dig('data', 'attributes')
  #
  #         expect(response.status).to eq(200)
  #         expect(project_data['status']).to eq(project_params[:status].to_s)
  #       end
  #     end
  #   end
  # end
end
