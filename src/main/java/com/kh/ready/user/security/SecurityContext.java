package com.kh.ready.user.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.kh.ready.user.repository.UserRepository;
import com.kh.ready.user.security.oauth.PrincipalOAuth2UserService;
import com.kh.ready.user.service.UserService;

@Configuration // xml로 설정에 한계가 있어 부득이하게 java 방식으로 config 설정
@EnableWebSecurity // security filter chain 가동
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true) // prePostEnabled -> 행동 전에 확인 
public class SecurityContext extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private CustomUserDetailService customUserDetailService;
	
	@Autowired
	private PrincipalOAuth2UserService principalOAuth2UserService;
	
	@Bean
	public BCryptPasswordEncoder encodePwd() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests()
				.antMatchers("/","/resources/**","/common/**","/book/**","/comm/list.kh","/que/list.kh").permitAll() // 모든 사용자가 접근가능
				.antMatchers("/user/**","/cart/**","/order/**","/comm/**","/que/**").hasAnyRole("USER","ADMIN") // 권한이 있는 유저만 접근가능
				.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')") // ADMIN 권한가진 유저만 접근 가능
				.anyRequest().permitAll() // 모든 요청에 권한 확인
			.and()
				.formLogin()
				.loginPage("/login")
				.usernameParameter("userId")
				.passwordParameter("userPassword")
				.loginProcessingUrl("/login")
				.defaultSuccessUrl("/")
			.and()
				.rememberMe() //로그인 유지
				.rememberMeParameter("remember-me")
				.tokenValiditySeconds(604800) // 1주일
				.userDetailsService(customUserDetailService)
			.and()
				.logout()
				.logoutSuccessUrl("/")
				.invalidateHttpSession(true).deleteCookies("JSESSIONID") // 로그아웃시 세션만료처리, 쿠키삭제
			.and()
				.oauth2Login() //소셜로그인 설정
				.loginPage("/login")
				.defaultSuccessUrl("/moreInfo")
				.userInfoEndpoint()
				.userService(principalOAuth2UserService);
		// 세션 최대 1개만 허용
		http.sessionManagement()
			.maximumSessions(1)
			.maxSessionsPreventsLogin(true)
			.expiredUrl("/login");
		// 권한 없는 사용자 접근시 예외처리
		http.exceptionHandling().accessDeniedPage("/denied");
	}
}
