package puresmap.domain.service.authority;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;


public abstract class AuthorityAdminDetails implements UserDetails{
    private static final long serialVersionUID = 1L;
    

    private List<? extends GrantedAuthority> authorities;

    public AuthorityAdminDetails() {
    	String temp = "";
        this.authorities = AuthorityUtils.createAuthorityList(temp);
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}
