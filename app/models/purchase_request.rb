class PurchaseRequest < ActiveRecord::Base
  scope :not_ordered, includes(:order_list).where('order_lists.ordered_at IS NULL')
  scope :ordered, includes(:order_list).where('order_lists.ordered_at IS NOT NULL')

  belongs_to :user, :validate => true
  has_one :order, :dependent => :destroy
  has_one :order_list, :through => :order

  validates_associated :user
  validates_presence_of :user, :title
  validate :check_price
  validates :url, :url => true, :allow_blank => true, :length => {:maximum => 255}
  after_save :index!
  after_destroy :index!
  before_save :set_date_of_publication
  attr_protected :user

  normalize_attributes :url, :pub_date

  searchable do
    text :title, :author, :publisher, :url
    string :isbn
    string :url
    integer :price
    integer :user_id
    integer :order_list_id do
      order_list.id if order_list
    end
    time :pub_date do
      date_of_publication
    end
    time :created_at
    time :accepted_at
    time :denied_at
    boolean :ordered do
      order_list.try(:ordered_at).present? ? true : false
    end
  end

  def self.per_page
    10
  end

  def check_price
    errors.add(:price) unless self.price.nil? || self.price > 0
  end

  def set_date_of_publication
    return if pub_date.blank?
    begin
      date = Time.zone.parse("#{pub_date}")
    rescue ArgumentError
      begin
        date = Time.zone.parse("#{pub_date}-01")
      rescue ArgumentError
        begin
          date = Time.zone.parse("#{pub_date}-01-01")
        rescue ArgumentError
          nil
        end
      end
    end
    self.date_of_publication = date
  end
end

# == Schema Information
#
# Table name: purchase_requests
#
#  id                  :integer         not null, primary key
#  user_id             :integer         not null
#  title               :text            not null
#  author              :text
#  publisher           :text
#  isbn                :string(255)
#  date_of_publication :datetime
#  price               :integer
#  url                 :string(255)
#  note                :text
#  accepted_at         :datetime
#  denied_at           :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  deleted_at          :datetime
#  state               :string(255)
#  pub_date            :string(255)
#

