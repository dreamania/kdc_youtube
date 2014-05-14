class Admin::ViralActionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @viral_actions = ViralAction.order("id desc").page(params[:page]).per(200)
    @viral_action_counts_daily = ViralAction.select(
      "date(convert_tz(viral_actions.created_at,'+00:00','+09:00')) as created_date,
      count(*) as total_count")
        .group("date(convert_tz(viral_actions.created_at,'+00:00','+09:00'))")
        .order("date(viral_actions.created_at)")
    @viral_action_counts_sum = ViralAction.select(
      "count(*) as total_count")
    @viral_platform_counts_daily = ViralAction.select(
      "date(convert_tz(viral_actions.created_at,'+00:00','+09:00')) as created_date,
      sum(case when viral_actions.platform = 'kakaostory' then 1 else 0 end) as kakaostory_count, 
    	sum(case when viral_actions.platform = 'kakaotalk' then 1 else 0 end) as kakaotalk_count, 
      sum(case when viral_actions.platform = 'purchase' then 1 else 0 end) as purchase_count, 
    	sum(case when viral_actions.platform = 'youtube' then 1 else 0 end) as youtube_count, 
    	count(*) as total_count")
        .group("date(convert_tz(viral_actions.created_at,'+00:00','+09:00'))")
        .order("date(viral_actions.created_at)")
    @viral_platform_counts_sum = ViralAction.select(
      "sum(case when viral_actions.platform = 'kakaostory' then 1 else 0 end) as kakaostory_count, 
      sum(case when viral_actions.platform = 'kakaotalk' then 1 else 0 end) as kakaotalk_count, 
      sum(case when viral_actions.platform = 'purchase' then 1 else 0 end) as purchase_count, 
      sum(case when viral_actions.platform = 'youtube' then 1 else 0 end) as youtube_count, 
      count(*) as total_count") 
  end
end
