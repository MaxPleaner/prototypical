class PagesController < ApplicationController
  def main
  end
  def company_search2
    return false
    render text: "asd"
  end

  def company_search
    # if params[:search].eql?("true")
    #   crunchbase_search = Company.crunchbase_search(company_params)
    #   angellist_search = Company.angellist_search(company_params) 
    #   linkedin_search = Company.linkedin_search(company_params) 
    #   @results = Array.new([
    #     crunchbase_search,
    #     angellist_search,
    #     linkedin_search,
    #   ]).flatten.ai(html: true)
    # end
    # render "company_search"
    render text: "asda"
    return false
    # render "company_search"
  end

  protected
  def company_params
    params.permit(:name, :location, :tags)
  end

end
