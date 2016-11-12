class Subscription < ActiveRecord::Base
  belongs_to  :user
  validates :model_id, presence: true
  def model
    Model.where(id: self.model_id).pluck(:name).first || ''
  end
  def make
    model = Model.find (self.model_id)
    return '' unless model
    Make.where(id: model.make_id).pluck(:name).first ||''
  end

  #Выбираем подписки, условиям которых удовлетворяет объявление  о продаже авто
  def self.users_to_sub (ad)
    model_id = Model.find_id_by_name(ad.model)
    return [] unless model_id
    Subscription.where( 'model_id IN (?) AND max_price >= ? AND min_year <= ? AND user_id IN (?)', \
      [model_id, 0], ad.price, ad.year, User.where(region_id: ad.region_id).ids).pluck(:user_id).uniq
  end

end
