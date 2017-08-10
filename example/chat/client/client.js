(function () {
    var d = document,
        w = window,
        p = parseInt,
        dd = d.documentElement,
        db = d.body,
        dc = d.compatMode == 'CSS1Compat',
        dx = dc ? dd: db,
        ec = encodeURIComponent;


    w.CHAT = {
        msgObj:d.getElementById("message"),
        screenheight:w.innerHeight ? w.innerHeight : dx.clientHeight,
        username:null,
        userid:null,
        socket:null,
        //���������������������Ͳ�
        scrollToBottom:function(){
            w.scrollTo(0, this.msgObj.clientHeight);
        },
        //�˳�������ֻ��һ���򵥵�ˢ��
        logout:function(){
            //this.socket.disconnect();
            location.reload();
        },
        //�ύ������Ϣ����
        submit:function(){
            var content = d.getElementById("content").value;
            if(content != ''){
                var obj = {
                    userid: this.userid,
                    username: this.username,
                    content: content
                };
                this.socket.emit('message', obj);
                d.getElementById("content").value = '';
            }
            return false;
        },
        genUid:function(){
            return new Date().getTime()+""+Math.floor(Math.random()*899+100);
        },
        //����ϵͳ��Ϣ�����������û����롢�˳���ʱ�����
        updateSysMsg:function(o, action){
            //��ǰ�����û��б�
            var onlineUsers = o.onlineUsers;
            //��ǰ��������
            var onlineCount = o.onlineCount;
            //�¼����û�����Ϣ
            var user = o.user;

            //������������
            var userhtml = '';
            var separator = '';
            for(key in onlineUsers) {
                if(onlineUsers.hasOwnProperty(key)){
                    userhtml += separator+onlineUsers[key];
                    separator = '��';
                }
            }
            d.getElementById("onlinecount").innerHTML = '��ǰ���� '+onlineCount+' �����ߣ������б�'+userhtml;

            //���ϵͳ��Ϣ
            var html = '';
            html += '<div class="msg-system">';
            html += user.username;
            html += (action == 'login') ? ' ������������' : ' �˳���������';
            html += '</div>';
            var section = d.createElement('section');
            section.className = 'system J-mjrlinkWrap J-cutMsg';
            section.innerHTML = html;
            this.msgObj.appendChild(section);
            this.scrollToBottom();
        },
        //��һ�������û��ύ�û���
        usernameSubmit:function(){
            var username = d.getElementById("username").value;
            if(username != ""){
                d.getElementById("username").value = '';
                d.getElementById("loginbox").style.display = 'none';
                d.getElementById("chatbox").style.display = 'block';
                this.init(username);
            }
            return false;
        },
        init:function(username){
            /*
             �ͻ��˸���ʱ������������uid,����ʹ���������û����ƿ����ظ���
             ʵ����Ŀ�У��������Ҫ�û���¼����ôֱ�Ӳ����û���uid������ʶ�Ϳ���
             */
            this.userid = this.genUid();
            this.username = username;

            d.getElementById("showusername").innerHTML = this.username;
            this.msgObj.style.minHeight = (this.screenheight - db.clientHeight + this.msgObj.clientHeight) + "px";
            this.scrollToBottom();

            //����websocket��˷�����
            this.socket = io.connect('ws://realtime.plhwin.com:3000');

            //���߷����������û���¼
            this.socket.emit('login', {userid:this.userid, username:this.username});

            //�������û���¼
            this.socket.on('login', function(o){
                CHAT.updateSysMsg(o, 'login');
            });

            //�����û��˳�
            this.socket.on('logout', function(o){
                CHAT.updateSysMsg(o, 'logout');
            });

            //������Ϣ����
            this.socket.on('message', function(obj){
                var isme = (obj.userid == CHAT.userid) ? true : false;
                var contentDiv = '<div>'+obj.content+'</div>';
                var usernameDiv = '<span>'+obj.username+'</span>';

                var section = d.createElement('section');
                if(isme){
                    section.className = 'user';
                    section.innerHTML = contentDiv + usernameDiv;
                } else {
                    section.className = 'service';
                    section.innerHTML = usernameDiv + contentDiv;
                }
                CHAT.msgObj.appendChild(section);
                CHAT.scrollToBottom();
            });

        }
    };
    //ͨ�����س����ύ�û���
    d.getElementById("username").onkeydown = function(e) {
        e = e || event;
        if (e.keyCode === 13) {
            CHAT.usernameSubmit();
        }
    };
    //ͨ�����س����ύ��Ϣ
    d.getElementById("content").onkeydown = function(e) {
        e = e || event;
        if (e.keyCode === 13) {
            CHAT.submit();
        }
    };
})();