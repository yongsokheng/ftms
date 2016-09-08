namespace :db do
  desc "remake database data"
  task rake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Create Universities"
    ["Vietnam National University, Hanoi", "Hanoi University of Science and Technology",
      "Foreign Trade University", "Hanoi University of Industry"].each do |name|
      Fabricate :university, name: name
    end

    puts "Create Programming Languages"
    ["Ruby", "PHP", "Android", "Java", "C"].each do |name|
      Fabricate :programming_language, name: name
    end

    puts "Create User Types"
    ["Intern", "VPG", "JPG", "New dev", "Tester"].each do |name|
      Fabricate :user_type, name: name
    end

    puts "Create Status"
    ["Inprogress", "Finish", "Prepare project", "Jointed project"].each do |name|
      Fabricate :status, name: name
    end

    puts "Creating Role"
    Fabricate :role, name: "admin", role_type: 0
    Fabricate :role, name: "trainer", role_type: 1
    Fabricate :role, name: "trainee", role_type: 2

    puts "Creating User"
    User.create!([
      {name: "Nguyen Binh Dieu", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Nguyen_Binh_Dieu.jpg")),
        email: "admin@tms.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Mai Tuan Viet", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Mai Tuan Viet.jpg")),
        email: "supervisor@tms.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyen Tien Trung", avatar: nil,
        email: "nguyen.tien.trung@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Truong Loc Binh", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Truong Loc Binh.jpg")),
        email: "truonglocbinh@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Vu Duc Luan", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Vu Duc Luan.jpg")),
        email: "vuducluan@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Ngo Van Thien ", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Ngo Van Thien.jpg")),
        email: "ngovanthie@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Ngo Van Duong", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Ngo Van Duong.jpg")),
        email: "ngovanduong@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyen Thai Son", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Nguyen Thai Son.jpg")),
        email: "nguyenthaison@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Mai Dinh Phu ", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Mai Dinh Phu.jpg")),
        email: "maidinhphu@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyen Van Hien", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Nguyen Van Hien.jpg")),
        email: "nguyenvanhien@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyen Thi Trang", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Nguyen Thi Trang.png")),
        email: "nguyenthitrang@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyen Thi Mo", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Nguyen Thi Mo.jpg")),
        email: "nguyenthimo@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Hoang Van Nam", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Hoang Van Nam.jpg")),
        email: "hoangvannam@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Du Thanh Hai", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Bui Quoc Viet.jpg")),
        email: "duthanhhai@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Mai Dinh Phi", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Nguyen Tuan Trong.jpg")),
        email: "maidinhphi@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Hoang Thi Linh", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/Hoang Thi Linh.jpg")),
        email: "hoangthilinh@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Dinh Hoang Hai", avatar: nil,
        email: "dinhhoanghai@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyen Sinh", avatar: nil,
        email: "nguyensinh@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyen Tuan Trong", avatar: nil,
        email: "nguyentuantrong@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Hoang Linh", avatar: nil,
        email: "hoanglinh@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Truong Thi Thao", avatar: nil,
        email: "truongthithao@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Can Van Nghi", avatar: nil,
        email: "canvannghi@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Luu Binh", avatar: nil,
        email: "luubinh@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Duong Phuong", avatar: nil,
        email: "duongphuong@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Ha Linh", avatar: nil,
        email: "halinh@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Ly Hoang Nam", avatar: nil,
        email: "lyhoangnam@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Mai Thao", avatar: nil,
        email: "maithao@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Dinh Phuong Linh", avatar: nil,
        email: "dinhphuonglinh@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Minh Phuong", avatar: nil,
        email: "minhphuong@gmail.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "So khen", avatar: nil,
        email: "sokhen@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Chenkim", avatar: nil,
        email: "chenkim@gmail.com",  password: "12345678",
        password_confirmation: "12345678"},
      {name: "Kooru", avatar: nil,
        email: "kooru@gmail.com",  password: "12345678",
        password_confirmation: "12345678"}
    ])

    puts "Creating Roles Manager && Trainer"
    User.first.user_roles.create! role_id: 1
    User.second.user_roles.create! role_id: 2
    User.third.user_roles.create! role_id: 2


    puts "Creating Location Manager && Trainer"
    Location.create! name: "Keangnam", user_id: 1
    Location.create! name: "Laboratory", user_id: 2
    Location.create! name: "Da Nang", user_id: 3

    puts "Creating User Roles, Profile && Location"
    User.offset(3).each do |user|
      user.user_roles.create! role_id: 3
      trainer = User.trainers.sample
      user.update_attributes trainer: trainer
      user.create_profile(
        start_training_date: Time.zone.today - 30,
        finish_training_date: Time.zone.today + 30,
        contract_date: Time.zone.today - 40,
        university_id: University.all.sample.id,
        programming_language_id: ProgrammingLanguage.all.sample.id,
        user_type_id: UserType.all.sample.id,
        status_id: Status.all.sample.id,
        location_id: trainer.profile_location_id)
    end

    puts "Creating Evaluation Template"
    ["Working days", "Number of task",
      "Implement with new techniques", "Git", "Rails basic",
      "Rails advance", "Coding convention", "Plus"].each do |name|
      Fabricate :evaluation_template, name: name
    end

    puts "Create Rank"
    5.times do
      Fabricate :rank
    end

    puts "Create Course"
    Course.create!([
      {name: "Ruby on Rails",
        image: File.open(File.join(Rails.root, "app/assets/images/course/Rails-1.png")),
        description: "Learn more Rails with this sequel to the infamous Rails for Zombies course. Increase your Ruby on Rails knowledge with even more zombie learning.",
        status: 1, programming_language_id: 1, start_date: Time.now, end_date: Time.now + 30.days},

      {name: "Android",
        image: File.open(File.join(Rails.root, "app/assets/images/Android.png")),
        description: "This tutorial will teach you basic Android programming and will also take you through some advance concepts related to Android application development.",
        status: 0, programming_language_id: 1, start_date: Time.now, end_date: Time.now + 30.days},

      {name: "PHP",
        image: File.open(File.join(Rails.root, "app/assets/images/PHP.png")),
        description: "PHP is a server scripting language, and a powerful tool for making dynamic and interactive Web pages",
        status: 1, programming_language_id: 1, start_date: Time.now, end_date: Time.now + 30.days},
    ])

    puts "Create Subject"
    Subject.create!([
      {name: "Ruby on Rails Tutorial Book", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/try-ruby.png")),
        description: "Learn the basic building blocks of Ruby, all in the browser.\r\n",
        content: "<p>Get an introduction to numbers, Strings, properties, and methods,&nbsp;
          Learn about conversions, arrays, variables, and more methods</p>\r\n", during_time: 12},
      {name: "Project 1 for Rails", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/Rails-2.png")),
        description: "Start Project 1 for Ruby on Rails today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: 12},
      {name: "Project 2 for Rails", image: File.open(File.join(Rails.root,
        "app/assets/images/Ruby.jpg")),
        description: "Start Project 1 for Ruby on Rails today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: 12},

      {name: "Git Tutorial", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/try-git.png")),
        description: "Start Git for your project today.\r\n",
        content: "<p>Get an introduction to github, code version management</p>\r\n", during_time: 12},

      {name: "Android Tutorial Book", image: File.open(File.join(Rails.root,
        "app/assets/images/Android.png")),
        description: "This tutorial will teach you basic Android programming and will also take you through some advance concepts related to Android application development.\r\n",
        content: "<p>Get an introduction to numbers, Strings, properties, and methods,&nbsp;
          Learn about conversions, arrays, variables, and more methods</p>\r\n", during_time: 12},
      {name: "Project 1 for Android", image: File.open(File.join(Rails.root,
        "app/assets/images/Android.png")),
        description: "Start Project 1 for Android today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: 12},
      {name: "Project 2 for Android", image: File.open(File.join(Rails.root,
        "app/assets/images/Android.png")),
        description: "Start Project 2 for Android today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: 12},

      {name: "PHP Tutorial Book", image: File.open(File.join(Rails.root,
        "app/assets/images/PHP.png")),
        description: "PHP is a server scripting language, and a powerful tool for making dynamic and interactive Web pages.\r\n",
        content: "<p>Get an introduction to numbers, Strings, properties, and methods,&nbsp;
          Learn about conversions, arrays, variables, and more methods</p>\r\n", during_time: 12},
      {name: "Project 1 for PHP", image: File.open(File.join(Rails.root,
        "app/assets/images/PHP.png")),
        description: "Start Project 1 for PHP today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: 12},
      {name: "Project 2 for PHP", image: File.open(File.join(Rails.root,
        "app/assets/images/PHP.png")),
        description: "Start Project 2 for PHP today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: 12},

    ])

    puts "Create Task Master"
    TaskMaster.create!([
      {name: "From zero to deploy",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "A toy app",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Mostly static pages",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Rails-flavored Ruby",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Filling in the layout",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Modeling users",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Sign up",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Basic login",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Advanced login",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Updating, showing, and deleting users",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Account activation",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Password reset",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "User microposts",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Following users",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},

      {name: "Requirement understanding",
        description: "Get an introduction to project understanding", subject_id: 2},
      {name: "Design Database", description: "Start design database", subject_id: 2},

      {name: "Requirement understanding",
        description: "Get an introduction to project understanding", subject_id: 3},
      {name: "Design Database", description: "Start design database", subject_id: 3},

      {name: "Getting Started",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Basics",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Branching",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git on the Server",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Distributed Git",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "GitHub",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Tools",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Customizing Git",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git and Other Systems",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Internals",
        description: "Get an introduction to project git", subject_id: 4},

      {name: "Installing environment",
        description: "Start your research with Android", subject_id: 5},
      {name: "Learn about Android architecture",
        description: "Start your research with Android", subject_id: 5},
      {name: "Learn about basic components of an Android application",
        description: "Start your research with Android", subject_id: 5},
      {name: "Learn about resources in Android",
        description: "Start your research with Android", subject_id: 5},
      {name: "Activity",
        description: "Start your research with Android", subject_id: 5},
      {name: "UI layout",
        description: "Start your research with Android", subject_id: 5},
      {name: "UI Controls",
        description: "Start your research with Android", subject_id: 5},
      {name: "Event Handling",
        description: "Start your research with Android", subject_id: 5},
      {name: "Animation",
        description: "Start your research with Android", subject_id: 5},
      {name: "Database",
        description: "Start your research with Android", subject_id: 5},
      {name: "Some other components",
        description: "Start your research with Android", subject_id: 5},
      {name: "Some other issues",
        description: "Start your research with Android", subject_id: 5},
      {name: "Thread",
        description: "Start your research with Android", subject_id: 5},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 6},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 7},

      {name: "Introduction to Laravel",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Installation",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Routing",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Middleware",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Controllers",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Request Lifecycle",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Application Structure",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Authentication",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Encryption",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Filesystem / Cloud Storage",
        description: "Get an introduction to Laravel", subject_id: 8},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 9},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 10}
    ])

    puts "Create Course Subject"
    CourseSubject.create!([
      {course_id: 1, subject_id: 1},
      {course_id: 1, subject_id: 2},
      {course_id: 1, subject_id: 3},
      {course_id: 1, subject_id: 4},

      {course_id: 2, subject_id: 4},
      {course_id: 2, subject_id: 5},
      {course_id: 2, subject_id: 6},
      {course_id: 2, subject_id: 7},

      {course_id: 3, subject_id: 4},
      {course_id: 3, subject_id: 8},
      {course_id: 3, subject_id: 9},
      {course_id: 3, subject_id: 10}
    ])

    puts "Creating UserCourse"
    UserCourse.create!([
      {active: true, user_id: 2, course_id: 1},
      {active: true, user_id: 3, course_id: 1},
      {active: true, user_id: 4, course_id: 1},
      {active: true, user_id: 5, course_id: 1},
      {active: true, user_id: 6, course_id: 1},
      {active: true, user_id: 7, course_id: 1},

      {active: false, user_id: 2, course_id: 2},
      {active: false, user_id: 8, course_id: 2},
      {active: false, user_id: 9, course_id: 2},
      {active: false, user_id: 10, course_id: 2},
      {active: false, user_id: 11, course_id: 2},
      {active: false, user_id: 12, course_id: 2},

      {active: false, user_id: 2, course_id: 3},
      {active: false, user_id: 13, course_id: 3},
      {active: false, user_id: 14, course_id: 3},
      {active: false, user_id: 15, course_id: 3},
      {active: false, user_id: 16, course_id: 3},
      {active: false, user_id: 17, course_id: 3}
    ])

    puts "Document"
    Document.create!([
      {name: "Ruby Books", content: File.open(File.join(Rails.root,
        "app/assets/images/Ruby.jpg")),
        documentable_id: 1, documentable_type: "Subject"},
      {name: "Rails advance", content: File.open(File.join(Rails.root,
        "app/assets/images/Ruby.jpg")),
        documentable_id: 2, documentable_type: "Subject"},
      {name: "Ruby + Git ", content: File.open(File.join(Rails.root,
        "app/assets/images/course/git.png")),
        documentable_id: 1, documentable_type: "Course"},
      {name: "Git book", content: File.open(File.join(Rails.root,
        "app/assets/images/course/git.png")), documentable_id: 3,
        documentable_type: "Subject"}
    ])

    puts "Creating Permissions"

    trainer_permissions = {
      Course: ["read"],
      CourseSubject: ["read"],
      Evaluation: ["read", "create", "update", "destroy"],
      Note: ["read", "create", "update", "destroy"],
      Notification: ["read", "create"],
      Subject: ["read"],
      User: ["read"],
      UserCourse: ["read"],
      UserSubject: ["update"],
      FeedBack: ["read"]
    }

    trainee_permissions = {
      Course: ["read"],
      Subject: ["read"],
      Task: ["read", "create", "update", "destroy"],
      User: ["read"],
      UserCourse: ["read"],
      UserSubject: ["update"],
      UserTask: ["read", "create", "update", "destroy"],
      FeedBack: ["create"]
    }

    trainer_permissions.each do |permission|
      permission[1].each do |action|
        Fabricate :permission, model_class: permission[0], action: action, role_id: 2
      end
    end

    trainee_permissions.each do |permission|
      permission[1].each do |action|
        Fabricate :permission, model_class: permission[0], action: action, role_id: 3
      end
    end
  end
end
