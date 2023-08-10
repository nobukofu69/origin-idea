class User < ApplicationRecord
  attr_accessor :is_guest_creation
  extend Devise::Models
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  enum gender: { male: 0, female: 1, other: 2 }
  has_many :consultants, class_name: 'Consultation', foreign_key: 'consultant_id'
  has_many :requesters, class_name: 'Consultation', foreign_key: 'requester_id'
  has_many :senders, class_name: 'Message', foreign_key: 'sender_id'

  validate :guest_email_cannot_be_used, unless: :is_guest_creation

  # ユーザーの年齢を返す
  def age
    now = Time.current.to_date
    birth_date = self.birthdate
    age = now.year - birth_date.year

    # 生年月日が今日の日付より後だった場合、年齢を1引く
    if now < birth_date.change(year: now.year)
      age -= 1
    end

    age
  end

# ゲストユーザーを作成
  def self.guest
    user = find_or_initialize_by(email: 'guest@example.com')
    user.is_guest_creation = true # ゲストユーザー作成時にこのフラグを設定
    user.name = 'ゲストユーザー'
    user.password = SecureRandom.urlsafe_base64
    user.birthdate = '1990-01-01'
    user.gender = :other
    user.profession = 'エンジニア'
    user.profile = 'エンジニア歴25年です｡好きな言語はRubyです｡'
    user.is_consultant = true
    user.skill = <<~TEXT
      スキル
      Ruby, Ruby on Rails, HTML, CSS, JavaScript, AWS, Docker

      得意分野
      バックエンド開発, フロントエンド開発, インフラ構築

      資格
      応用情報技術者, 基本情報技術者, AWS認定ソリューションアーキテクト
    TEXT
    user.save!
    user
  end

  # ログインユーザーがゲストユーザーかどうかを判定する
  def guest_user?(current_user)
    current_user == User.find_by(email: 'guest@example.com')
  end

  private

  # ゲストユーザーのメールアドレスを使用できないようにする
  def guest_email_cannot_be_used
    if email == 'guest@example.com'
      errors.add(:email, "このメールアドレスは使用できません。")
    end
  end
end