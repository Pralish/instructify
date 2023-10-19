# frozen_string_literal: true

module TenantResolvable
  extend ActiveSupport::Concern

  included do
    set_current_tenant_through_filter
    before_action :find_tenant_by_subdomain_or_domain
  end

  private

  def find_tenant_by_subdomain_or_domain
    subdomain = request.subdomains.last
    query = subdomain.present? ? { subdomain: subdomain.downcase } : { domain: request.domain.downcase }
    set_current_tenant(Organization.where(query).first)
  end
end
