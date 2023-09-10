//
//  Message.swift
//  ios_ceo


import Foundation

//MARK: - MESSAGE KEYWORD
let kLoginToContinue = "Vui lòng đăng nhập để tiếp tục."
let kValidatorSignNameInvalid = "Vui lòng nhập họ tên"
let kValidatorDisplayNameInvalid = "Vui lòng nhập tên hiển thị"

let kValidatorPhoneInvalid = "Vui lòng nhập số điện thoại"
let kValidatorPhoneNumberInvalid = "Số điện thoại không đúng"
let kValidatorEmail = "Email không đúng định dạng"
let kPasswordInvalid = "Vui lòng nhập lại mật khẩu"
let kPasswordMatchInvalid = "Mật khẩu không trùng với nhau"
let kPasswordLengthInvalid = "Mật khẩu phải ít nhất 6 kí tự"
let kKeyReEnterPassInvalid = "Vui lòng nhập lại mật khẩu vừa nhập"
let kValidatorKeyNewPassInvalid = "Mật khẩu mới không đúng"
let kValidatorKeyConfirmNewPassInvalid = "Mật khẩu mới nhập lại không đúng"

let kMsgValidDictrict = "Vui lòng nhập quận huyện"
let kMsgValidAddress = "Vui lòng nhập địa chỉ"

let kLoginSuccess = "Đăng nhập thành công"
let kValidatorNameInvalid = "Vui lòng nhập họ và tên"
let kValidatorGenderInvalid = "Vui lòng chọn giới tính"
let kValidatorBirthdayInvalid = "Vui lòng chọn ngày sinh"
let kValidatorArtistNameInvalid = "Vui lòng nhập Nghệ danh"
let kValidatorHometown = "Nhập quê quán"
let kValidatorWorkplace = "Nhập nơi làm việc"
let kValidatorAddressInvalid = "Vui lòng nhập địa chỉ"
let kValidatorFirstLineMusicInvalid = "Vui lòng nhập dòng nhạc thứ nhất"
let kValidatorSecondLineMusicInvalid = "Vui lòng nhập dòng nhạc thứ hai"
let kValidatorFieldActivityInvalid = "Vui lòng nhập lĩnh vực hoạt động"
let kValidatorTimeActivityInvalid = "Vui lòng nhập thời gian hoạt động"
let kValidatorArtistTypeInvalid = "Vui lòng chọn loại nghệ sỹ"
let kValidatorDateBookingInvalid = "Vui lòng chọn ngày biễu diễn"
let kValidatorFromTimeBookingInvalid = "Vui lòng chọn thời gian bắt đầu"
let kValidatorToTimeBookingInvalid = "Vui lòng nhập số giờ biển diễn"
let kValidatorToTimeBookingInvalid2 = "Số giờ biển diễn cần lớn hơn 0"
var kValidatorPrice : String = "Vui lòng nhập giá dịch vụ (Tối thiểu : \(MIN_PAYMENT.formatnumberVND())"
let kMsgDelete = "Bạn chắc chắn muốn xoá nội dung này ?"
let kButtonDeletes = ["Đồng ý", "Huỷ"]
//MARK: - GUIDE
let kContentGuideFirst = "Ứng dụng tìm kiếm nghệ sỹ đầu tiên tại Việt Nam"
let kContentGuideSecond = "Rất nhiều ca sỹ với thể loại và phong cách đa dạng, tài năng"
let kContentGuideThirdth = "Dễ dàng đặt lịch với giá cả phù hợp với ngân sách của bạn"
let guideBtnStart = "Bắt đầu"

//MARK: - Common
let comPhone = "Số điện thoại"
let comPasword = "Mật khẩu"
let comBtnRegis = "Đăng ký"
let comForgotPas = "Quên mật khẩu"
let comName = "Họ và tên"
let comAddress = "Địa chỉ"
let comGender = "Giới tính"
let comFont = "Helvetica Neue"
let comFontMedium = "Helvetica Neue Medium"
let comAppName = "Tìm kiếm nghệ sỹ"
let kMsgNoData = "Không có dữ liệu"

//MARK: - Login
let loginShow = "Hiển thị"
let login = "Đăng nhập"
let kNotificationTitle = "Notification"
let kErrorTitle = "Error"
let kMsgEmptyPassword = "Vui lòng nhập vào mật khẩu của bạn"
let kMsgEmptyConfirmPassword = "Vui lòng xác nhận mật khẩu của bạn"
let kMsgMinimumPasswordLength = "Mật khẩu phải dài tối thiểu 6 ký tự"
let kMsgEmail = "Please input Email"
let kMsgFormatPhone = "Vui lòng nhập vào số điện thoại đúng định dạng"
let kMsgEnterPassword = "Nhập lại mật khẩu không trùng khớp, vui lòng thử lại"
let kpassword = "Vui lòng nhập vào mật khẩu mới"
//MARK: - Register
let kMsgSomethingWentWrong = "Đã có lỗi xảy ra, vui lòng thử lại"
let regisRepass = "Nhập lại mật khẩu"
let regisNavTitle = "ĐĂNG KÍ TÀI KHOẢN"

//MARK: - Phone confirm
let pcTitle = "Nhập số điện thoại"
let pcContinue = "Tiếp tục"

//MARK: - Code confirm
let codeTitle = "Nhập mật mã"
let codeGuide = "Vui lòng nhập mã code đã gửi qua số điện thoại của bạn"
let codeResend = "Gửi lại"
let codeChangeNumber = "Thay đổi số điện thoại"

//MARK: - Update Profile
let upBtnSubmit = "Cập nhật thông tin"
let upDob = "Ngày tháng năm sinh"
let kFullName = "Vui lòng nhập tên"
let kGender = "Vui lòng nhập giới tính"
let kAddress = "Vui lòng nhập địa chỉ"
let kBirthDay = "Vui lòng nhập ngày sinh nhật"
let kvalidateEmail = "Vui lòng nhập email đúng định dạng"
//MARK: - Confirm Booking History
let cbTitle = "Xác nhận lịch đặt"
let cbShow = "Thông tin show"
let cbPlace = "Nơi biểu diễn"
let cbNote = "Ghi chú"
let cbDate = "Ngày"
let cbPayment = "Thanh toán"
let cbPrice = "Giá show"
let cbTime = "Thời gian biểu diễn"
let cbTotal = "Số tiền"
let cbAccountInfor = "Tài khoản thanh toán"
let cbUpdate = "Cập nhật"

//MARK: - Update Payment
let udTitle = "Cập nhật thanh toán"
let udType = "Loại thẻ"
let udNametitle = "Nhập tên chủ thẻ"
let udExpiretitle = "Ngày hết hạn"
let udCodetitle = "Mã bảo mật"
let udCardNumber = "Nhập số thẻ"
let udVisa = "VISA"
let udMaster = "MASTER"

//MARK: - Inform Booking
let ibTitle = "Đã gửi yêu cầu đặt lịch đến"
let ibInfor = "Nghệ sỹ sẽ phản hồi yêu cầu của bạn trong thời gian sớm nhất, vui lòng để ý thông báo hoặc kiểm tra trong mục"
let ibHistory = "Lịch sử đặt"
let ibBtnDone = "Xong"

//MARK: - Booking
let bkTitle = "Đặt Lịch"
let bkCityChoice = "Chọn thành phố"
let bkArtistChoice = "Chọn thể loại nghệ sỹ"
let bkDate = "Chọn ngày biểu diễn"
let bkTo = "Số giờ biểu diễn"
let bkFrom = "Chọn giờ"
let bkBtnSearch = "Tìm kiếm"
let bkHcm = "TP HỒ CHÍ MINH"
let bkHN = "TP HÀ NỘI"
let bKDn = "TP ĐÀ NẴNG"

//MARK: - Setting
let setTitle = "Tài khoản"
let setEdit = "Chỉnh sửa trang cá nhân"
let setEditProfile = "Xem và chỉnh sửa hồ sơ nghệ sĩ"

let setDeleteAccount = "Xóa tài khoản"
let setPolicy = "Chính sách và điều kiện"
let setPayment = "Thanh toán và thẻ"
let setLogout = "Đăng xuất"
let kMsgMyFeed = "Bài đăng của tôi"
//MARK: - Schedule List
let slEvaluation = " Đánh giá"
let slView = "Xem profile"
let slTitle = "KẾT QUẢ"

//MARK: - Profile
let pBooking = "Đặt lịch"
let pTitle = "THÔNG TIN NGHỆ SỸ"
let pIntroduce = "Giới thiệu"
let pBirth = "Ngày tháng năm sinh"
let pGender = "Giới tính"
let pHomeTown = "Quê quán"
let pWorkingPlace = "Nơi làm việc"
let pExperience = "Năm hoạt động"
let pPrice = "Giá show"
let pCityPrice = "Nội thành"
let pOutside = "Ngoại thành"
let pContact = "Liên hệ"
let pMore = "mỗi giờ thêm"
let pActivities = "Hoạt động"
let pEvaluation = "Đánh giá"

//MARK: - Update Address
let udBooking = "Đặt lịch"
let udPageTitle = "NHẬP ĐỊA CHỈ"
let udLocationTitle = "Nhập địa chỉ"
let udDeatilTitle = "Ghi chú về địa chỉ"

//MARK: - Boooking Success
let bsSuccess = "Đặt lịch thành công"
let bsInfor = "Thông tin show"
let bsDone = "Hoàn tất"
let bsName = "Tên nghệ sỹ"
let bsType = "Biểu diễn"
let bsPlace = "Nơi biểu diễn"
let bsAddress = "Địa chỉ"
let bsTime = "Ngày giờ"

//MARK: - Boooking Completion
let bcComplete = "Đã hoàn thành show diễn"
let bsInform = "Vui lòng đánh giá nghệ sỹ để cải thiện dịch vụ được tốt hơn"
let bsHolder = "Nhập đánh giá của bạn"
let bsSend = "Gửi đánh giá"
let bsSkip = "Bỏ qua"



//MARK: - Title
let kCity = "Chọn thành phố"
let kContentCity = "TP.HỒ CHÍ MINH"
let kSinger = "Chọn nghệ sỹ biểu diễn"
let kContentSinger = "Ca sỹ (Vocalist)"
let kDate = "Chọn ngày/giờ biểu diễn"
let kContentDate = "07/05/2020"
let kTypeCard = "Loại thẻ"
let kVISA = "VISA"
let kWarningNotAddCard = "Hiện tại bạn chưa có tài khoản thanh toán"
//MARK: - WITHDRAW
let kMinWithdrawAlert = String.init(format: "Số tiền trong ví không đủ để rút. Số tiền tối thiểu phải là %@", MIN_WITHDAW.formatnumberVND())
let kInputWithdrawAlert = String.init(format: "Số tiền cần rút phải lớn hơn hoặc bằng %@", MIN_WITHDAW.formatnumberVND())
